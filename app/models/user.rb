class User < ActiveRecord::Base
  mount_uploader :profile_photo, ProfilePhotoUploader

  def is_admin?
    role == 'admin'
  end

  validates :username, presence: true, uniqueness: true, length: { in: 3..15 },
      format: { with: /[a-z0-9]/ }, format: { without: /[^a-z0-9]/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
