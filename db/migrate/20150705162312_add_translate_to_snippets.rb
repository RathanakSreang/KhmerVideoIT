class AddTranslateToSnippets < ActiveRecord::Migration
  def self.up
    Snippet.create_translation_table!({
      content: :text
    }, {
      migrate_data: true
    })
  end

  def self.down
    Snippet.drop_translation_table! migrate_data: true
  end
end
