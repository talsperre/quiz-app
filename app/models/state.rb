class State < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  validates :count,  presence: true
  validates :score,  presence: true
end
