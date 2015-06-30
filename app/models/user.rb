class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true, length: { in: 3..15 },
  format: { with: /[a-z0-9]/}, format: { without: /[^a-z0-9]/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
