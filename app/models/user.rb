class User < ApplicationRecord
  before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :group, presence: true

  belongs_to :group

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token(42)
      break token unless User.find_by(authentication_token: token)
    end
  end
end
