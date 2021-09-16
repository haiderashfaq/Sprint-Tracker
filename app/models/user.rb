class User < ApplicationRecord
  sequenceid :company, :users
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id', dependent: :nullify
  has_many :created_issues, class_name: 'Issue', foreign_key: 'creator_id', dependent: :nullify
  has_many :reviewed_issues, class_name: 'Issue', foreign_key: 'reviewer_id', dependent: :nullify
  has_many :projects_users
  has_many :projects, through: :projects_users

  belongs_to :company
  accepts_nested_attributes_for :company
  validates :email, presence: true, uniqueness: { scope: :company_id }
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }, unless: -> { new_member }
  validates :phone_num, presence: true, length: { minimum: 6, maximum: 15 }
  validates :name, presence: true, length: { minimum: 2, maximum: 40 }

  ROLE_ID = { admin: 1, member: 2 }.freeze
  validates :role_id, presence: true, inclusion: { in: ROLE_ID.values }

  attr_accessor :new_member

  def has_password?
    encrypted_password.present?
  end

  def account_owner?
    id == company.owner_id
  end

  def admin?
    role_id == ROLE_ID[:admin]
  end

  def member?
    role_id == ROLE_ID[:member]
  end

  def role_name
    if account_owner?
      I18n.t('roles.account_owner')
    elsif admin?
      I18n.t('roles.admin')
    else
      I18n.t('roles.member')
    end
  end

  def password_required?
    return false if new_member

    super
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
