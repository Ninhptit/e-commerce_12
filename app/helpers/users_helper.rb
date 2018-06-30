module UsersHelper
  def gravatar_for user
    image_tag user.avatar, alt: user.name, class: "img-responsive"
  end
end
