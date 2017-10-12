class Subcategory < ApplicationRecord
  has_many :quizzes, dependent: :destroy
  has_many :scores, dependent: :destroy
  validates :category_id, presence: true
  validates :name,  presence: true, length: { maximum: 100 },
            uniqueness: { case_sensitive: false }
  belongs_to :category
end
