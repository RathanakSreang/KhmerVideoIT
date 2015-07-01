class RenameVideoFileInVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :file, :file_link
  end
end
