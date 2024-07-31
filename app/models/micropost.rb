class Micropost < ApplicationRecord
  ALLOWED_PARAMS = %i(content image).freeze
  belongs_to :user
  has_one_attached :image
  validates :content, presence: true,
            length: {maximum: Settings.models.micropost.content_length}
  validates :image,
            content_type: {in: %w(image/jpeg image/gif image/png),
                           message: I18n.t("models.microposts.img_error")},
            size: {less_than: Settings.models.micropost.img_size.megabytes,
                   message: I18n.t("models.microposts.size_error")}
  scope :recent_posts, ->{order created_at: :desc}
  has_one_attached :image do |attachable|
    attachable.variant :display,
                       resize_to_limit: [Settings.models.micropost.from,
                         Settings.models.micropost.to]
  end
end
