class AddActsAsCategoryFieldsToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :children_count, :integer, :default=> 0
    add_column :categories, :ancestors_count, :integer, :default=> 0
    add_column :categories, :descendants_count, :integer, :default=> 0

    add_column :categories, :hidden, :boolean
  end

  def self.down
    remove_column :categories, :children_count
    remove_column :categories, :ancestors_count
    remove_column :categories, :descendants_count
    remove_column :categories, :hidden
  end
end
