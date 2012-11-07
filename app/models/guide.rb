class Guide < ActiveRecord::Base
  attr_accessible :content, :name

  validates_presence_of :name, :on => :create
end
