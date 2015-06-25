class AddTutorialIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :tutorial_id, :integer
  end
end
