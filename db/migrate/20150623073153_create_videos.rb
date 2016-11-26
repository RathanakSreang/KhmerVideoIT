class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :file
      t.string :file_link
      t.string :image
      t.string :slug
      t.integer :user_id
      t.integer :duration
      t.integer :comments_count, default: 0
      t.boolean :status
      t.text :description
      t.datetime :publish_date
      t.timestamps null: false
    end
    add_index :videos, :slug, unique: true
  end
end
