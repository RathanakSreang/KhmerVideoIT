class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      # t.integer :commentable_id
      # t.string :commentable_type
      t.belongs_to :commentable, polymorphic: true
      t.string  :ancestry
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
    add_index :comments, :ancestry
  end
end
