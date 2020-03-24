class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # disable type column name restrections
  self.inheritance_column = :sti_disabled

  def as_json(*)
    super.except("created_at", "updated_at").tap do |hash|
      if defined?(self.area) && self.area.present?
        hash["area"] = { mi²: self.area, km²: (self.area * 2.59).truncate(2) } 
      end
      if defined?(self.id) && self.id.present?
        hash["id"] = self.id.is_a?(Array) ? self.id.first : self.id
      end
    end
  end
end
