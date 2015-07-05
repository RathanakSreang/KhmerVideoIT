class AddTranslateToUsefullink < ActiveRecord::Migration
   def self.up
    UsefullLink.create_translation_table!({
      title: :string   
    }, {
      migrate_data: true
    })
  end

  def self.down
    UsefullLink.drop_translation_table! migrate_data: true
  end
end
