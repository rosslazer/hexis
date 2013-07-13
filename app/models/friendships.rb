class Friendships < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key =>'friend_id'
end
