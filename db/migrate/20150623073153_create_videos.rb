class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :file
      t.integer :duration
      t.timestamps null: false
    end
  end
end
