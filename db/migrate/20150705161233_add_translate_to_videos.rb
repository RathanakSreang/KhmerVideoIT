class AddTranslateToVideos < ActiveRecord::Migration
   def self.up
    Video.create_translation_table!({
      title: :string,      
      description: :text
    }, {
      migrate_data: true
    })
  end

  def self.down
    Video.drop_translation_table! migrate_data: true
  end
end
