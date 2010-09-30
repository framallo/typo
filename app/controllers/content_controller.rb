# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
class ContentController < ApplicationController
  class ExpiryFilter
    def before(controller)
      @request_time = Time.now
    end

    def after(controller)
       future_article =
         Article.find(:first,
                      :conditions => ['published = ? AND published_at > ?', true, @request_time],
                      :order =>  "published_at ASC" )
       if future_article
         delta = future_article.published_at - Time.now
         controller.response.lifetime = (delta <= 0) ? 0 : delta
       end
    end
  end

  include LoginSystem
  before_filter :setup_themer
  before_filter :featured_categories
  before_filter :most_popular_articles
  helper :theme

  protected

  # TODO: Make this work for all content.
  def auto_discovery_feed(options = { })
    with_options(options.reverse_merge(:only_path => true)) do |opts|
      @auto_discovery_url_rss = opts.url_for(:format => 'rss')
      @auto_discovery_url_atom = opts.url_for(:format => 'atom')
    end
  end

  def theme_layout
    this_blog.current_theme.layout(self.action_name)
  end

  helper_method :contents
  def contents
    if @articles
      @articles
    elsif @article
      [@article]
    elsif @page
      [@page]
    else
      []
    end
  end

  private
  def featured_categories
    @featured_category=Category.find_or_create_by_name('Auto shows')
    @featured=Article.in_category(@featured_category.descendants_ids_and_self).newest.top(9)
  end

  def most_popular_articles
    @most_popular_articles=Article.are_published.most_popular.top(6)
  end

end
