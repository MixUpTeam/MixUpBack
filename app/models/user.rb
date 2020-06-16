class User < ApplicationRecord
	after_create :create_profile

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
					   :recoverable, :rememberable, :validatable

	has_one :user_profile, dependent: :destroy
	has_many :playlists, foreign_key: :owner_id, dependent: :destroy

	def create_profile
		UserProfile.create(user: self)
	end
end
