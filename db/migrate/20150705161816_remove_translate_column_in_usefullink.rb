class RemoveTranslateColumnInUsefullink < ActiveRecord::Migration
  def change
    remove_column :usefull_links, :title
  end
end
