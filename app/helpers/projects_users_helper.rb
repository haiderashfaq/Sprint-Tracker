module ProjectsUsersHelper
  def user_role(project, projects_users)
    case projects_users.user
    when project.manager then t('shared.manager')
    when @current_company.owner then t('shared.owner')
    else t('shared.member')
    end
  end
end
