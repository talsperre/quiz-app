class Score < ApplicationRecord
  belongs_to :user
  #belongs_to :quiz
  #belongs_to :subcategory
  #belongs_to :category
  validates :total,  presence: true
end
