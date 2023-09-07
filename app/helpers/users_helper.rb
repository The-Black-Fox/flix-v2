module UsersHelper

  def profile_image(user, size=80)
    gravatar_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.name} Gravatar" )
  end
end
