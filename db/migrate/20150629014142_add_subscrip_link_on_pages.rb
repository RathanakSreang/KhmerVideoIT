class AddSubscripLinkOnPages < ActiveRecord::Migration
  def change
    add_column :pages, :ff_link, :string
    add_column :pages, :tw_link, :string
    add_column :pages, :yt_link, :string
  end
end
