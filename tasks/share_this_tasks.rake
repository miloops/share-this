namespace :share_this do
  desc "Copy assets used by Share This in the public directory"
  task :setup do
    FileUtils.copy(File.join(File.dirname(__FILE__), "..", "assets", "stylesheets", "share_this.css"),
      File.join(RAILS_ROOT, "public", "stylesheets"))
    FileUtils.copy(File.join(File.dirname(__FILE__), "..", "assets", "images", "share_this_pixel.gif"),
      File.join(RAILS_ROOT, "public", "images"))
    FileUtils.copy(File.join(File.dirname(__FILE__), "..", "assets", "images", "share_this_icons.gif"),
      File.join(RAILS_ROOT, "public", "images"))
    puts "Remember to include share_this.css in your view!"
  end
end
