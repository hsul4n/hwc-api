class CreateMedicalTables < ActiveRecord::Migration[6.0]
  def change
    # Medical::Disease
    create_table :medical_diseases, id: false do |t|
      t.string :id,          null: false, primary_key: true
      t.json   :name,        null: false
      t.json   :description

      t.timestamps
    end

    # Medical::Disease::Case
    create_table :medical_disease_cases, primary_key: %i[id disease_id] do |t|
      t.bigint  :id,           null: false
      t.string  :continent_id, limit: 2
      t.string  :country_id,   limit: 2
      t.string  :level1_id,    limit: 8
      t.string  :disease_id,   null: false
      t.integer :type,         null: false
      t.date    :date,         null: false

      t.timestamps
    end
    add_foreign_key :medical_disease_cases, :geo_continents,               column: :continent_id
    add_foreign_key :medical_disease_cases, :geo_countries,                column: :country_id
    add_foreign_key :medical_disease_cases, :geo_country_division_level1s, column: :level1_id
    add_foreign_key :medical_disease_cases, :medical_diseases,             column: :disease_id
    
  end
end
  