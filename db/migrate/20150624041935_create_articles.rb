class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
      t.integer :video_id

      t.timestamps null: false
    end
  end
end
