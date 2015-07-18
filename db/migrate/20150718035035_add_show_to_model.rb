class AddShowToModel < ActiveRecord::Migration
  def change
    add_column :videos, :status, :integer, default: :show
    add_column :videos, :publish_date, :datetime
    add_column :articles, :status, :integer, default: :show
    add_column :articles, :publish_date, :datetime
  end
end
