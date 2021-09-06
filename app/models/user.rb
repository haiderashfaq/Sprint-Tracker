class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :projects_users
  has_many :projects, through: :projects_users

  ROLE = { admin: 1, member: 2 }.freeze

  def admin?
    role_id == ROLE[:admin]
  end

  def member?
    role_id == ROLE[:member]
  end
end
