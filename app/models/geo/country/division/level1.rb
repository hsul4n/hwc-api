class Geo::Country::Division::Level1 < ApplicationRecord
  self.primary_key = :id, :country_id

  belongs_to :country
end
