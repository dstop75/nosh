class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :cart
  has_many :orders

  has_secure_password

  before_create :generate_token

  private

    def generate_token
      return if token.present?
      begin
        self.token = SecureRandom.uuid.gsub(/\-/, '')
      end while self.class.exists?(token: token)
    end
end
