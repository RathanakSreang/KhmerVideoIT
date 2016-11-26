class CreateVideoTags < ActiveRecord::Migration
  def change
    create_table :video_tags do |t|
      t.integer :video_id
      t.integer :tag_id

      t.timestamps null: false
    end
    add_index :video_tags, [:video_id, :tag_id]
  end
end
