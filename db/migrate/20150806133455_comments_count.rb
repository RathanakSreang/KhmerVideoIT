class CommentsCount < ActiveRecord::Migration
  def up
    execute "update videos set comments_count=(select count(*) from comments where commentable_type = 'Video' and commentable_id = videos.id)"
    execute "update articles set comments_count=(select count(*) from comments where commentable_type = 'Article' and commentable_id = articles.id)"
    execute "update questions set comments_count=(select count(*) from comments where commentable_type = 'Question' and commentable_id = questions.id)"
  end

  def down
    
  end
end
