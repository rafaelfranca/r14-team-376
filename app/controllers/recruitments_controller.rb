class RecruitmentsController < ApplicationController
  def show
    position = current_user.organization.positions.find(params[:position_id])
    @recruitment = position.recruitments.find(params[:id])
  end

  def new
    @position = current_user.organization.positions.find(params[:position_id])
    @candidate = Candidate.new
  end

  def create
    @position = current_user.organization.positions.find(params[:position_id])
    recruitment = @position.recruitments.build
    candidate_params = params.require(:candidate).permit(:name, :email, :github, :twitter, :linkedin, :skype)
    @candidate = recruitment.build_candidate(candidate_params)

    if recruitment.save
      redirect_to @position, notice: 'Recruitment created with success.'
    else
      render 'new'
    end
  end
end
