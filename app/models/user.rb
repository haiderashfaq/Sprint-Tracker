class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def self.get_role_id(string)
    Role[string]
  end

  def admin?
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
end
