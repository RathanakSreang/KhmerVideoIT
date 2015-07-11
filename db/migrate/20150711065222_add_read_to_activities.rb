class AddReadToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :read, :boolean, default: false
    add_column :activities, :user_tracked_id, :integer
  end
end
