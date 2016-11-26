class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :language_id
      t.integer :user_id
      t.integer :comments_count, default: 0, null: false
      t.boolean :status
      t.datetime :publish_date
      t.string :slug
      t.string :title
      t.text :content
      t.text   :description

      t.timestamps null: false
    end
    add_index :articles, :slug, unique: true
    add_index :articles, :user_id
    add_index :articles, :language_id
    add_index :articles, :title, unique: true
  end
end
