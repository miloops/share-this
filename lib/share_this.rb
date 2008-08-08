require 'apis/facebook'
require 'apis/digg'
require 'apis/stumble_upon'
require 'apis/my_space'
require 'apis/delicious'

module ShareThis
  def share_this(options = {})
    apis = [*options.delete(:include)] if options[:include]
    apis ||= [:facebook, :digg, :stumble_upon, :delicious, :my_space]

    apis.inject('') do |t, v|
       t << construct_api(v, options) + (options[:separator] || "&nbsp;")
    end
  end

  protected
  def share_this_url(url = nil)
    url ? url : "#{request.protocol}#{request.host_with_port}#{request.request_uri}"
  end

  def share_this_title(title = nil)
    title ? "encodeURIComponent('#{title}')" : "encodeURIComponent(document.title)"
  end

  def construct_api(api, options = {})
    api = api.to_s.classify
    if ShareThis.constants.include?(api)
      api = "ShareThis::#{api}".constantize
    else
      raise NameError, "Invalid API name: #{api}"
    end

    url = ''
    url << api::BASE_URL
    url << "#{api::URL_PARAM}=#{share_this_url(options[:url])}"
    url << "&#{api::TITLE_PARAM}=' + #{share_this_title(options[:title])} + '"
    url << api::EXTRA_PARAM.join unless api::EXTRA_PARAM.empty?


    # Don't show the API name if discard name is given as an option.
    name  = options[:discard_name]  ? '' : content_tag(:span, api::NAME)

    # Don't show the API image if discard image is given as an option.
    image = options[:discard_image] ? '' : image_tag("share_this_pixel.gif",
      :class => api::STYLE, :alt => '', :width => 16, :height => 16)
    image << "&nbsp;" unless image.blank? || options[:discard_name]

    "<script type=\"#{Mime::JS}\">document.write('#{link_to(image + name, url, :target => :blank)}')</script>"
  end
end