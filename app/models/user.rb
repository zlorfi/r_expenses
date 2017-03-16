class User < ApplicationRecord
  before_save :ensure_authentication_token
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :organization, presence: true

  belongs_to :organization
  has_many :expenses

  def ensure_authentication_token
    return unless authentication_token.blank?
    self.authentication_token = generate_authentication_token
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token(42)
      break token unless User.find_by(authentication_token: token)
    end
  end
end
