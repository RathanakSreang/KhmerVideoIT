class CreateUsefullLinks < ActiveRecord::Migration
  def change
    create_table :usefull_links do |t|
      t.string :title
      t.string :link
      t.integer :video_id

      t.timestamps null: false
    end
  end
end
