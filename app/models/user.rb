class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id', dependent: :nullify
  has_many :created_issues, class_name: 'Issue', foreign_key: 'creator_id', dependent: :nullify
  has_many :reviewed_issues, class_name: 'Issue', foreign_key: 'reviewer_id', dependent: :nullify

  ROLE_ID = { admin: 1, member: 2 }.freeze

  def admin?
    role_id == ROLE_ID[:admin]
  end

  def member?
    role_id == ROLE_ID[:member]
  end
end
