class AddCommentsCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :comments_count, :integer, default: 0, null: false
  end
end
