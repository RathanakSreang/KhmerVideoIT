class RemoveTranslateColumnInArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :title
    remove_column :articles, :content
    remove_column :articles, :description
  end
end
