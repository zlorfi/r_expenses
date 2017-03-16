module UsersHelper
  def current_organization
    current_user.organization_id
  end
end
