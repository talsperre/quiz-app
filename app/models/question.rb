class Question < ApplicationRecord
  belongs_to :quiz
  has_many :q_states, dependent: :destroy
  has_many :q_images, dependent: :destroy
  validates :name,  presence: true
  validates :qtype,  presence: true
  validates :content,  presence: true
  validates :option_one,  presence: true
  validates :option_two,  presence: true
  validates :option_three,  presence: true
  validates :option_four,  presence: true
  validates :answer,  presence: true
end
