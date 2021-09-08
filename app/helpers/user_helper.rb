module UserHelper
  def get_roles(role_id)
    role_id.map { |key, index| [key.capitalize, index] }
  end

  def role_name(role_id, user_id)
    case role_id
    when 1
      if user_id == Company.current_company.owner_id
        'Company Owner'
      else
        'Admin'
      end
    when 2
      'Member'
    end
  end
end
