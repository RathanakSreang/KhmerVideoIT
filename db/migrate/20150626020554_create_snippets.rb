class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :content
      t.string :language_id
      t.integer :video_id

      t.timestamps null: false
    end
    add_index :snippets, :video_id
    add_index :snippets, :language_id
  end
end
