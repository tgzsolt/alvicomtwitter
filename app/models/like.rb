class Like < ActiveRecord::Base
  attr_accessible :micropost_id, :liker_id, :scale
  
  belongs_to :liker, class_name: "User"
  belongs_to :micropost
  
  validates :liker_id, presence: true
  validates :micropost_id, presence: true
end
