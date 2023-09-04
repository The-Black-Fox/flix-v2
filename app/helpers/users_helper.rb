module UsersHelper

  def profile_image(user)
    gravatar_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(gravatar_url, alt: "#{user.name} Gravatar" )
  end
end
