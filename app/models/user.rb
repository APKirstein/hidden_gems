class User < ActiveRecord::Base
  has_many :reviews

  mount_uploader :profile_photo, ProfilePhotoUploader

  def admin?
    role == 'admin'
  end

  validates :username, presence: true
  validates :username, length: { in: 3..15 }
  validates :username, uniqueness: true
  # validates :username, format: { with: /[a-z0-9]/ }
  validates :username, format: { without: /[^a-z0-9]/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
