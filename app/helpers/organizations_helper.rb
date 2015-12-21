module OrganizationsHelper

  def display_avatar(user)
    user.avatar? ? user.avatar_url(:thumb) : image_path("no-image.png")
  end
end
