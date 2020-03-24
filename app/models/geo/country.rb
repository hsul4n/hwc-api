class Geo::Country < ApplicationRecord
  belongs_to :continent
  belongs_to :capital

  has_many :levels, class_name: "Division::Level"
  has_many :level1, class_name: "Division::Level1"
end

