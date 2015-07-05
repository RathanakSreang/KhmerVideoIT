class RemoveTranslateColumnInVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :title
    remove_column :videos, :description
  end
end
