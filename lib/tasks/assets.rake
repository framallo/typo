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
    require 'yui/compressor' 

    require 'app/helpers/application_helper'
    require "#{Blog.default.current_theme.path}/helpers/theme_helper.rb" if File.exists? "#{Blog.default.current_theme.path}/helpers/theme_helper.rb"
    class AssetHelper
      extend ThemeHelper
      extend ApplicationHelper
    end

    js_file = super_concat '.js', 'javascripts', AssetHelper.all_js_files
    save_asset 'javascripts/production.js', compress_asset(js_file, :compressor=> YUI::JavaScriptCompressor)

    css_file = super_concat '.css','stylesheets', AssetHelper.all_css_files
    save_asset 'stylesheets/production.css', compress_asset(css_file, :compressor=> YUI::CssCompressor)
  end

  def super_concat(ext, base_path, files)
    fs = files.collect {|f| File.join Rails.root, 'public', base_path, f + ext }
    fs.collect do |f| 
      if File.exists?(f)
        file = File.new(f,'r')
        file.read if file
      else
        puts "file missing #{f}" 
      end
    end.compact.join("\n")
  end

  def compress_asset(input, opts)
    opts[:compressor] ||= YUI::CssCompressor # or YUI::JavaScriptCompressor
    opts[:compressor_options] ||= {}

    compressor = opts[:compressor].new(opts[:compressor_options])
    r = compressor.compress(input)
  end

  def save_asset(filename, content)
    f = File.join Rails.root, "public", filename
    puts "Created compressed file #{f}"
    File.open(f, "w") { |file| file.write(content) }
  end

end
