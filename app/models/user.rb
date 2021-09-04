class User < ApplicationRecord
	sequenceid :company , :users
  sequenceid :company, :users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  belongs_to :company
  accepts_nested_attributes_for :company
  validates :email, presence: true, uniqueness: { scope: :company_id }
  #validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  ROLE = { admin: 1, member: 2 }.freeze

  def self.get_role
    ROLE.map{|key, index| [key.capitalize, index]}
  end

  def self.get_role_id(string)
    ROLE[string]
  end

  def account_owner?
    id == company.owner_id
  end

 def admin?
    role_id == ROLE[:admin]
  end

  def member?
    role_id == ROLE[:member]
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
