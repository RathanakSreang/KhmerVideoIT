class ChangeStatusDatatype < ActiveRecord::Migration
  def change
    change_column :articles, :status, :boolean, default: :true    
  end
end
