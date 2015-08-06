class AddCommentsCountToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :comments_count, :integer, default: 0, null: false
  end
end
