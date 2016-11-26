class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :action
      t.belongs_to :trackable, polymorphic: true, index: true
      t.boolean :read, default: false
      t.integer :user_tracked_id

      t.timestamps null: false
    end
    add_index :activities, :user_tracked_id
  end
end
