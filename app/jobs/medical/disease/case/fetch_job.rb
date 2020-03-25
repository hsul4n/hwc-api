require 'csv'
require 'open-uri'

class Medical::Disease::Case::FetchJob < ApplicationJob
  queue_as :default

  def perform(last_case)
    jhu(last_case)
  end

  private
  JHU_DATE_INDEX = 4
  JHU_DATE_FORMAT = "%m/%d/%y"
  JHU_PATH = "csse_covid_19_data/csse_covid_19_time_series"
  JHU_DATA = [
    "time_series_covid19_confirmed_global",
    "time_series_covid19_deaths_global",
  ]
  JHU_COUNTRY = {
    "Holy See": "VA",
    "Korea, South": "KR",
    "Taiwan*": "TW",
    "Congo (Kinshasa)": "CD",
    "Republic of the Congo": "CD",
    "Saint Vincent and the Grenadines": "VC",
    "Cote d'Ivoire": "CI",
    "Congo (Brazzaville)": "CG",
    "The Gambia": "GM",
    "Gambia, The": "GM",
    "The Bahamas": "BS",
    "Bahamas, The": "BS",
    "Reunion": "RE",
    "Cape Verde": "CV",
    "East Timor": "TP"
  }

  # Johns Hopkins University
  # source: https://github.com/CSSEGISandData/COVID-19
  def jhu(last_case)
    countries = Geo::Country.all
    level1s = Geo::Country::Division::Level1.all
    
    # get case id because we're using compose primary key with disease_id
    last_case_id = last_case.id.first

    JHU_DATA.each_with_index do |file, file_index|
      data = CSV.parse(open("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/#{JHU_PATH}/#{file}.csv"))

      # dates (header from csv)
      dates = data[0].slice(JHU_DATE_INDEX..-1)

      # case per day
      case_per_day = data.drop(1).map { |row|
        days = {}

        # add every day to map for ex: {"2020/20/20": "291"}
        # key is date and value is case count
        dates.each_with_index { |date, i|
          day = Date.strptime(date, JHU_DATE_FORMAT)
          col = i + JHU_DATE_INDEX
          days[day] = (row[col] || 0).to_i - (i > 0 ? (row[col - 1] || 0) : 0).to_i
        }

        # reject outdate data
        days.reject! { |day| last_case&.date >= day }
      }.reject(&:empty?)

      if case_per_day.any?
        current_date = DateTime.now
        new_cases = []

        # drop header and start mapping
        data.drop(1).each_with_index do |row, i|
          # Try to find by name, id, juh mapped country
          country = countries.find { |c|
            c.name["en"] == row[1] || c.id == row[1] || c.id == JHU_COUNTRY.find { |k,v| k.to_s == row[1] }&.last
          }

          # Find country level1
          level1 = level1s.find { |l| l.country_id == country&.id && l.name["en"] = row[0] }

          case_per_day[i].each do |date, case_count|
            case_count.times do
              new_cases << {
                id: last_case_id+=1,
                continent_id: country&.continent_id,
                country_id: country&.id,
                level1_id: level1&.id&.first,
                disease_id: last_case.disease_id,
                type: file_index + 1,
                date: date,
                created_at: current_date,
                updated_at: current_date,
              }
            end
          end
        end

        Medical::Disease::Case.insert_all!(new_cases)

        p "#{new_cases.length} NEW CASE #{file}"
      else
        p "#{file} UP TO DATE"
      end
    end
  end
end
