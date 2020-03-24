class Medical::Disease < ApplicationRecord
  has_many :cases
end
