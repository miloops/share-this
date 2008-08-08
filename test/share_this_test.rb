require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
ENV['RAILS_ASSET_ID'] = ''

module ShareThis
  class RequestMock
    class << self
    def protocol; "http://"; end
    def host_with_port; "www.example.com"; end
    def request_uri; "/articles/1"; end
  end
  end
  
  def request; RequestMock; end
end

class ShareThisTest < Test::Unit::TestCase
  include ShareThis
  include ActionView::Helpers::AssetTagHelper

  def test_should_share_this
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '" target="blank"><img alt="" class="icn_share_facebook" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>Facebook</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://digg.com/submit?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '&phase=2" target="blank"><img alt="" class="icn_share_digg" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>Digg</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://www.stumbleupon.com/submit?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '" target="blank"><img alt="" class="icn_share_stumbleupon" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>StumbleUpon</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://del.icio.us/post?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '&v=4&jump=close&noui=yes" target="blank"><img alt="" class="icn_share_delicious" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>del.icio.us</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://www.myspace.com/Modules/PostTo/Pages/?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '&l=1" target="blank"><img alt="" class="icn_share_myspace" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>MySpace</span></a>')</script>&nbsp;),
      share_this
  end
  
  def test_should_share_this_without_name
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '" target="blank"><img alt="" class="icn_share_facebook" height="16" src="/images/share_this_pixel.gif" width="16" /></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://digg.com/submit?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '&phase=2" target="blank"><img alt="" class="icn_share_digg" height="16" src="/images/share_this_pixel.gif" width="16" /></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://www.stumbleupon.com/submit?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '" target="blank"><img alt="" class="icn_share_stumbleupon" height="16" src="/images/share_this_pixel.gif" width="16" /></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://del.icio.us/post?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '&v=4&jump=close&noui=yes" target="blank"><img alt="" class="icn_share_delicious" height="16" src="/images/share_this_pixel.gif" width="16" /></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://www.myspace.com/Modules/PostTo/Pages/?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '&l=1" target="blank"><img alt="" class="icn_share_myspace" height="16" src="/images/share_this_pixel.gif" width="16" /></a>')</script>&nbsp;),
      share_this(:discard_name => true)
  end
  
  def test_should_share_this_without_image
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '" target="blank"><span>Facebook</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://digg.com/submit?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '&phase=2" target="blank"><span>Digg</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://www.stumbleupon.com/submit?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '" target="blank"><span>StumbleUpon</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://del.icio.us/post?url=http://www.example.com/articles/1&title=' + encodeURIComponent(document.title) + '&v=4&jump=close&noui=yes" target="blank"><span>del.icio.us</span></a>')</script>&nbsp;<script type="text/javascript">document.write('<a href="http://www.myspace.com/Modules/PostTo/Pages/?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '&l=1" target="blank"><span>MySpace</span></a>')</script>&nbsp;),
      share_this(:discard_image => true)
  end

  def test_should_share_this_for_one_api
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '" target="blank"><img alt="" class="icn_share_facebook" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>Facebook</span></a>')</script>&nbsp;),
      share_this(:include => :facebook)
  end
  
  def test_should_share_this_for_one_api_without_image
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.example.com/articles/1&t=' + encodeURIComponent(document.title) + '" target="blank"><span>Facebook</span></a>')</script>&nbsp;),
      share_this(:include => :facebook, :discard_image => true)
  end
  
  def test_should_share_this_for_one_api_with_custom_title
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.example.com/articles/1&t=' + encodeURIComponent('A random custom title') + '" target="blank"><img alt="" class="icn_share_facebook" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>Facebook</span></a>')</script>&nbsp;),
      share_this(:include => :facebook, :title => "A random custom title")
  end

  def test_should_share_this_for_one_api_with_custom_url
    assert_equal %Q(<script type="text/javascript">document.write('<a href="http://www.facebook.com/sharer.php?u=http://www.exameple.com/articles/&t=' + encodeURIComponent(document.title) + '" target="blank"><img alt="" class="icn_share_facebook" height="16" src="/images/share_this_pixel.gif" width="16" />&nbsp;<span>Facebook</span></a>')</script>&nbsp;),
      share_this(:include => :facebook, :url => "http://www.exameple.com/articles/")
  end
end
