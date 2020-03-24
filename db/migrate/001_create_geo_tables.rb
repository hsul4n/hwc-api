class CreateGeoTables < ActiveRecord::Migration[6.0]
  def change
    # Geo::Continents
    create_table :geo_continents, id: false do |t|
      t.string  :id,          null: false, limit: 2, primary_key: true
      t.json    :name,        null: false
      t.integer :area,        null: false

      t.timestamps
    end
    
    # Geo::Country
    create_table :geo_countries, id: false do |t|
      t.string  :id,           null: false, limit: 2, primary_key: true
      t.string  :continent_id, null: false, limit: 2
      t.string  :capital_id,   limit: 8
      t.json    :name,         null: false
      t.integer :area,         null: false
      t.integer :dial,         null: false, unique: true
      t.json    :nationality

      t.timestamps
    end
    add_foreign_key :geo_countries, :geo_continents, column: :continent_id
    
    # Geo::Country::Division
    ## Geo::Country::Division::Level
    create_table :geo_country_division_levels, primary_key: %i[country_id level] do |t|
      t.string  :continent_id, null: false, limit: 2
      t.string  :country_id,   null: false, limit: 2
      t.integer :level,        null: false
      t.json    :name,         null: false

      t.timestamps
    end
    add_foreign_key :geo_country_division_levels, :geo_continents, column: :continent_id
    add_foreign_key :geo_country_division_levels, :geo_countries,  column: :country_id
    
    ## Geo::Country::Division::Level1
    create_table :geo_country_division_level1s, primary_key: %i[id country_id] do |t|
      t.string  :id,           null: false, limit: 8
      t.string  :continent_id, null: false, limit: 2
      t.string  :country_id,   null: false, limit: 2
      t.bigint  :capital_id
      t.json    :name,         null: false
      t.integer :area
      t.integer :dial

      t.timestamps
    end
    add_foreign_key :geo_country_division_level1s, :geo_continents, column: :continent_id
    add_foreign_key :geo_country_division_level1s, :geo_countries,  column: :country_id
    
    # Geo::Coordinates
    create_table :geo_coordinates do |t|
      t.string :coordinatesable_type, null: false
      t.string :coordinatesable_id,   null: false
      t.float  :latitude,             null: false, max: 30
      t.float  :longitude,            null: false, max: 30

      t.timestamps
    end
    add_index :geo_coordinates, [:coordinatesable_type, :coordinatesable_id], name: :ploymorphic_index    
  end
end
  