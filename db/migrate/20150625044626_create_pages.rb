class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :about

      t.timestamps null: false
    end
  end
end
