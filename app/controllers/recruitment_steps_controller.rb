class RecruitmentStepsController < ApplicationController
  def show
    @step = Recruitment.find(params[:recruitment_id]).steps.find(params[:id])
  end

  def approve
    recruitment = Recruitment.find(params[:recruitment_id])
    @step = recruitment.steps.find(params[:id])

    if @step.update(state: 'approved')
      redirect_to [recruitment.position, recruitment], notice: 'Candidate approved on this step'
    end
  end

  def reprove
    recruitment = Recruitment.find(params[:recruitment_id])
    @step = recruitment.steps.find(params[:id])

    if @step.update(state: 'reproved')
      redirect_to [recruitment.position, recruitment], notice: 'Candidate reproved on this step'
    end
  end
end
