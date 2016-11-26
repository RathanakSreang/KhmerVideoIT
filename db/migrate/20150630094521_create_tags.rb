class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :user_id
      t.string :slug

      t.timestamps null: false
    end
    add_index :tags, :name, unique: true
    add_index :tags, :slug, unique: true
    add_index :tags, :user_id
  end
end
