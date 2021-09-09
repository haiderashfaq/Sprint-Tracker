class ListCompaniesController < ApplicationController

  def list_company
    @companies = Company.joins('INNER JOIN users ON users.company_id= companies.id').where('users.email = ?', params[:email])
    render :list_company
  end
end
