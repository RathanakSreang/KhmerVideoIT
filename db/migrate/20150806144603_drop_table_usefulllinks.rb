class DropTableUsefulllinks < ActiveRecord::Migration
  def change
    drop_table :usefull_links
  end
end
