class PersonalUser < ApplicationRecord
  belongs_to :personal
  belongs_to :user
end
