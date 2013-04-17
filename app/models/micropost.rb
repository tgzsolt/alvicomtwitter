class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :liker
    
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'microposts.created_at DESC'
  
  def self.from_users_followed_by(user)
    #nice but not scalable
    #followed_user_ids = user.followed_user_ids
    #where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
    
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
  
  def likeby?(user)
    likes.find_by_liker_id(user.id)
  end

  def likeby!(user)
    likes.create!(liker_id: user.id)
  end
  
  def unlikeby!(user)
    likes.find_by_liker_id(user.id).destroy
  end

end