namespace :assets do
  desc 'copy theme assets'
  task :copy_theme_assets => :environment do
    zap_theme_caches
    copy_theme_assets
  end

  def zap_theme_caches
    FileUtils.rm_rf(%w{stylesheets javascript images}.collect{|v| ActionController::Base.page_cache_directory + "/#{v}/theme"})
    FileUtils.rm_rf(%w{stylesheets javascripts images}.collect{|v| File.join(RAILS_ROOT, 'public',v, 'theme')})
  end

  def copy_theme_assets
    %w{stylesheets javascripts images}.collect do |v| 
      puts src = File.join(Blog.default.current_theme.path, v)
      puts dst = File.join(RAILS_ROOT, 'public',v, 'theme')
      FileUtils.cp_r(src,dst) if File.exists?(src)
    end
  end

  desc 'compress static assets'
  task :compress => :environment do
    TypoAssets.compress
  end

  desc 'compress static assets'
  task :concat => :environment do
    TypoAssets.concat_js
    TypoAssets.concat_css
  end

end
