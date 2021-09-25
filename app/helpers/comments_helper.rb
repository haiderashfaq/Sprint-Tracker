module CommentsHelper

  def get_user_name(value)
    User.find_by(id: value.to_i)&.name if User.find_by(id: value.to_i).prsent?
  end
end
