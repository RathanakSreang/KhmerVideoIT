class AddUserIdToVideoArticleTag < ActiveRecord::Migration
  def change
    add_column :videos, :user_id, :integer
    add_column :articles, :user_id, :integer
    add_column :tags, :user_id, :integer
  end
end
