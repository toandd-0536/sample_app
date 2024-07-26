class User < ApplicationRecord
  has_secure_password
  before_save :downcase_email

  validates :name,
            presence: true,
            length: {maximum: Settings.models.user.name.max_length}
  validates :email,
            presence: true,
            length: {maximum: Settings.models.user.email.max_length},
            format: {with: Settings.models.user.email.valid_email_regex}
  attr_accessor :remember_token
  scope :ordered, ->{order :created_at}
  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
