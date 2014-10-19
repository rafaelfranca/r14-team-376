class RecruitmentStepsController < ApplicationController
  def show
    @step = Recruitment.find(params[:recruitment_id]).steps.find(params[:id])
  end
end
