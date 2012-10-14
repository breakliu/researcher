class UsersPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user_id, :scope => :post_id

  attr_accessible :user_id, :post_id, :operate_post_flag
end
