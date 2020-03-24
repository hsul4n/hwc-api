class Medical::Disease::Case < ApplicationRecord
  self.primary_key = :id, :disease_id

  has_one :country, class_name: "Geo::Country"
  has_one :level1,  class_name: "Geo::Country::Division::Level1"

  enum type: { sure: 1, died: 2, heal: 3 }
end