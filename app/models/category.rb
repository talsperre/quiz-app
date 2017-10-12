class Category < ApplicationRecord
  has_many  :subcategories, dependent: :destroy
  has_many  :scores, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 100 },
            uniqueness: { case_sensitive: false }
end
