class RemoveTranslateColumnInTags < ActiveRecord::Migration
  def change
    remove_column :tags, :name
  end
end
