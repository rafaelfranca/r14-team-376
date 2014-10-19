class CommentsController < ApplicationController
  def create
    step = RecruitmentStep.find(params[:recruitment_step_id])

    comment_params = params.require(:comment).permit(:body).merge(author_id: current_user.id)
    step.comments.create(comment_params)

    redirect_to recruitment_recruitment_step_url(step.recruitment, step)
  end
end
