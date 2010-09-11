class AddFeedSourceAndUrlToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :feed_entry_url, :string
    add_column :contents, :feed_source_id, :integer
  end

  def self.down
    remove_column :contents, :feed_entry_url
    remove_column :contents, :feed_source_id
  end
end
