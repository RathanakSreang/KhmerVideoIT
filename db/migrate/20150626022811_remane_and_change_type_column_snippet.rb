class RemaneAndChangeTypeColumnSnippet < ActiveRecord::Migration
  def change
    rename_column :snippets, :header, :video_id
    change_column :snippets, :video_id, :integer
  end
end
