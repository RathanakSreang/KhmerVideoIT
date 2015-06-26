class DropSomeTable < ActiveRecord::Migration
  def change
    drop_table :video_snippets
    drop_table :article_snippets
  end
end
