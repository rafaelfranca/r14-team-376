module ApplicationHelper
  def avatar(avatar_url, alt: nil, size: '64', **options)
    if avatar_url
      terminator = avatar_url =~ /\?/ ? '&' : '?'
      high_definition_size = size.to_i * 2
      url = high_definition_size > 0 ? avatar_url + "#{terminator}s=#{high_definition_size}" : avatar_url

      image_tag(url, size: size, alt: alt, title: alt, **options)
    else
      high_definition_size = size.to_i * 2

      image_tag("profile.png", size: size, alt: alt, title: alt, **options)
    end
  end
end
