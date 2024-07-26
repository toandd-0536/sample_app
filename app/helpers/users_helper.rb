module UsersHelper
  def gravatar_for user, options = {size: Settings.helpers.users.size_default}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = format(Settings.links.gravatar, gravatar_id:, size:)
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def can_destroy_user user
    current_user.admin? && !current_user?(user)
  end
end
