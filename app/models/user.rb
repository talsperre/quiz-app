class User < ApplicationRecord
  require 'securerandom'

  has_many  :scores, dependent: :destroy
  has_many  :states, dependent: :destroy
  has_many  :q_states, dependent: :destroy
  has_many  :lifelines, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.password = SecureRandom.urlsafe_base64(10)
      user.email = auth.info.email
      user.gender = auth.info.gender
      user.save!
    end
  end
end
