class User < ActiveRecord::Base
  has_secure_password

  enum role: [:admin, :user, :guest]

  include UserRole

  after_initialize :set_default_role, if: :new_record?
  before_create :generate_authentication_token

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, :presence => true, :if => '!password.nil?'

  def self.confirm(email_params, password_params)
    user = User.find_by(email: email_params)
    user.authenticate(password_params)
  end

  def set_default_role
    self.role ||= :user
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break unless User.find_by(authentication_token: authentication_token)
    end
  end
end
