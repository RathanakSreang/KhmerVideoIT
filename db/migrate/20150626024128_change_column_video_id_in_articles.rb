class ChangeColumnVideoIdInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :video_id, :language_id
  end
end
