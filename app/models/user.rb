class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  not_multitenant
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
end
