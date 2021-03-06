class User < ApplicationRecord
  after_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  has_one :user_profile, dependent: :destroy
  has_many :playlists, foreign_key: :owner_id, dependent: :destroy
  has_many :track_playlists, foreign_key: :added_by_id, dependent: :destroy

  delegate :username, to: :user_profile

  acts_as_voter

  def create_profile
    UserProfile.create(user: self)
  end
end
