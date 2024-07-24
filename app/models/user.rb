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

  private
  def downcase_email
    email.downcase!
  end
end
