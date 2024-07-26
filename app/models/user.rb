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

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end
  private
  def downcase_email
    email.downcase!
  end
end
