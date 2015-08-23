class ChangeVideoStatusDatatype < ActiveRecord::Migration
  def change
    change_column :videos, :status, :boolean, default: :true
  end
end
