class RenameLanguageToLanguageIdInTutorials < ActiveRecord::Migration
  def change
    rename_column :tutorials, :language, :language_id
    change_column :tutorials, :language_id, :integer
  end
end
