class UserProfile < ApplicationRecord
 validates_uniqueness_of :user_id
 validates :username, uniqueness: { case_sensitive: false }, on: :update

 belongs_to :user
end
