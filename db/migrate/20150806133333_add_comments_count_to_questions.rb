class AddCommentsCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :comments_count, :integer, default: 0, null: false
  end
end
