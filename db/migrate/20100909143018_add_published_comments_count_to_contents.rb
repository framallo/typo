class AddPublishedCommentsCountToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :published_comments_count, :integer, :default=>0
  end

  def self.down
    remove_column :contents, :published_comments_count
  end
end
