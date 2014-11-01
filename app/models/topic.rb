class Topic < ActiveRecord::Base
  has_many :notifications

  validates_uniqueness_of :name
end
