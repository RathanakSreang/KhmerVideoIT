class RemoveTranslateColumnInPages < ActiveRecord::Migration
  def change
    remove_column :pages, :about    
  end
end
