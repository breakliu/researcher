class Term < ActiveRecord::Base
  attr_accessible :name

  has_many :posts

  default_scope :order => 'created_at desc'
end
