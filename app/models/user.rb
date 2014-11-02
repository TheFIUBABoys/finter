class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_topics, dependent: :destroy
  has_many :topics, through: :user_topics

  validates_presence_of :username
  validates_uniqueness_of :username, case_sensitive: false
end
