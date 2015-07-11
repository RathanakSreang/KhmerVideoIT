class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  
  scope :unread_activity,-> (user_id){
    # where(read: false, user_id: !user_id)
    where("activities.user_id != ? AND activities.read = ?", user_id, false)
  }

  scope :all_activity,-> (user_id){    
    where("activities.user_id != ?", user_id)
  }
end
