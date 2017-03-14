module UsersHelper
  def current_group
    current_user.group_id
  end
end
