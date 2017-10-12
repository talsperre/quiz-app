class Quiz < ApplicationRecord
  has_many  :questions, dependent: :destroy
  has_many  :scores, dependent: :destroy
  has_many  :q_states, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 100 },
             uniqueness: { case_sensitive: false }
  belongs_to :subcategory
end
