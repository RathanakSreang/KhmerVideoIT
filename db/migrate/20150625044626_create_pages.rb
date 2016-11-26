class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :content
      t.string :title
      t.string :ff_link
      t.string :tw_link
      t.string :yt_link

      t.timestamps null: false
    end
    add_index :pages, :title, unique: true
  end
end
