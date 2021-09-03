class User < ApplicationRecord
  sequenceid :company, :users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  belongs_to :company
  accepts_nested_attributes_for :company
  validates :email, presence: true, uniqueness: { scope: :company_id }
  #validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  Role = { 'admin' => 1, 'member' => 2 }

  def self.get_role
    Role.map{|key, index| [key.capitalize, index]}
  end

  def self.get_role_id(string)
    Role[string]
  end

  def account_owner?
    id == company.owner_id
  end

  def admin?
    puts role_id
    case role_id
    when 1
      true
    else
      false
    end
  end

  def member?
    case role_id
    when 2
      true
    else
      false
    end
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
