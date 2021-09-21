class CompaniesController < ApplicationController
  def search
    binding.pry
    respond_to do |format|
      format.html
    end
  end
end
