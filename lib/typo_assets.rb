class TypoAssets
  $css_files ||= []
  $js_files ||= []
  $js_bottom_files ||= []

  def self.add_js(*args)
    add($js_files, args)
  end

  def self.add_bottom_js(*args)
    add($js_bottom_files, args)
  end
  
  def self.add_css(*args)
    add($css_files, args)
  end

  def self.js
    ($js_files + $js_bottom_files).uniq
  end

  def self.css
    $css_files.uniq
  end

  def self.compress
    require 'yui/compressor' 
    build_production_js compress_asset(super_concat_js, :compressor=> YUI::JavaScriptCompressor)
    build_production_css compress_asset(super_concat_css, :compressor=> YUI::CssCompressor)
  end

  def self.concat_js
    build_production_js super_concat_js
  end

  def self.concat_css
    build_production_css super_concat_css
  end

  private

  def self.super_concat_js
    super_concat '.js', 'javascripts', self.js
  end

  def self.super_concat_css
    super_concat '.css','stylesheets', self.css
  end

  def self.build_production_js(content)
    save_asset 'javascripts/production.js',content
  end

  def self.build_production_css(content)
    save_asset 'stylesheets/production.css',content
  end

  def self.super_concat(ext, base_path, files)
    fs = files.collect {|f| File.join Rails.root, 'public', asset_path(base_path,f,ext) }
    fs.collect do |f| 
      if File.exists?(f)
        file = File.new(f,'r')
        file.read if file
      else
        puts "file missing #{f}" 
      end
    end.compact.join("\n")
  end

  def self.asset_path(base_path,f,ext)
   f =~ /^\// ? f : File.join(base_path,f + ext)
  end

  def self.compress_asset(input, opts)
    opts[:compressor] ||= YUI::CssCompressor # or YUI::JavaScriptCompressor
    opts[:compressor_options] ||= {}

    compressor = opts[:compressor].new(opts[:compressor_options])
    r = compressor.compress(input)
  end

  def self.save_asset(filename, content)
    f = File.join Rails.root, "public", filename
    puts "Created compressed file #{f}"
    File.open(f, "w") { |file| file.write(content) }
  end

  def self.add(array, files)
    files = [files] unless files.is_a?(Array)
    array.concat(files)
  end

end

#
#puts TypoAssets.css.size ; TypoAssets.css ; reload!
