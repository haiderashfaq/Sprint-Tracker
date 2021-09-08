class ListCompaniesController < ApplicationController
  def list_company
    @companies = Company.joins('INNER JOIN users ON users.company_id= companies.id').where('users.email = ?', params[:email])
    render :list_company
    if @companies
      format.html { redirect_to @issue, notice: t('shared.success.create', resource_label: t('issues.issue_label'))  }
    else
      flash.now[:error] = t('shared.failure.create', resource_label: t('issues.issue_label'))
      format.html { render :new }
    end
  end
end
