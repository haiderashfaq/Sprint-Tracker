class ListCompaniesController < ApplicationController
  def list_company
    @companies = Company.joins('INNER JOIN users ON users.company_id= companies.id').where('users.email = ?', params[:email])
    respond_to do |format|
      if @companies.any?
        format.html { render :list_company }
      end
    end
  end
end
