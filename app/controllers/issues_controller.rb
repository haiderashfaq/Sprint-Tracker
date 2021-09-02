class IssuesController < ApplicationController
 
  load_and_authorize_resource find_by: :sequence_num, through: :current_company
 
  # GET /issues or /issues.json
  def index
    # @issues = Issue.all
    @issues = Issue.accessible_by(current_ability).paginate(page: params[:page])
  end

  # GET /issues/1 or /issues/1.json
  def show;
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit; end

  # POST /issues or /issues.json
  def create
    #binding.pry
    @issue.creator = current_user

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @company = Company.current_company
    @issue = @company.issues.find_by_sequence_num!(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def issue_params

    params.require(:issue).permit(:title, :description, :status, :category, :priority, :estimated_end_date,
                                  :estimated_start_date)
  end
end
