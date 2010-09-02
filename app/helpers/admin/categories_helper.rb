module Admin::CategoriesHelper
  def show_actions item
    html = <<-HTML 
      <div class='action' style='margin-top: 10px;'>
        <small>#{link_to_permalink item, pluralize(item.descendants_articles.size, _('no articles') , _('1 article'), __('%d articles'))}</small> |
        <small>#{link_to _("Edit"), :action => 'edit', :id => item.id}</small> |
        <small>#{link_to _("Delete"), :action => 'destroy', :id => item.id}</small>
    </div>
    HTML
  end

  def category_tree(all_categories, options = {})
    config = {:matrix => false, :url => {}, :update => 'tree_rights_remote', :deactivate_links => false}
    config.update(options) if options.is_a?(Hash)
    roots = all_categories.map {|c| c unless c.parent}.compact
    roots.collect { |root| category_tree_category(root, all_categories, config) }
  end
  
  def  category_tree_category(category, all_categories, config)
    children = all_categories.map {|c| c if c.parent == category}.compact
    result = '&nbsp;' * category.ancestors_count * 3
    #require 'ruby-debug'
    #debugger
    result += render :partial =>'admin/categories/category', :locals=> {:category => category}
    unless children.empty? then
      children.each { |child| result += category_tree_category(child, all_categories, config) }
    end
    result
  end

end
