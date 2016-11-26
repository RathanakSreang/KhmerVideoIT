class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.integer :article_id
      t.integer :tag_id

      t.timestamps null: false
    end
    add_index :article_tags, [:article_id, :tag_id]
  end
end
