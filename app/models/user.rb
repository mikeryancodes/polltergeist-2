class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  attr_reader :password

  after_initialize :ensure_session_token!

  has_many :poll_groups,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: "PollGroup"

  has_many :polls,
  through: :poll_groups,
  source: :polls

  has_many :answer_choices,
  through: :poll_groups,
  source: :answer_choices

  has_many :responses,
  through: :answer_choices,
  source: :responses

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token!
    self.session_token ||= self.class.generate_session_token
  end
end
