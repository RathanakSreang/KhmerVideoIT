class DropLanguage < ActiveRecord::Migration
  def change
    drop_table :languages
  end
end
