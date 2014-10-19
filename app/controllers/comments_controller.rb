class CommentsController < ApplicationController
  def create
    # TODO: scope by position?
    step = RecruitmentStep.find(params[:recruitment_step_id])

    comment_params = params.require(:comment).permit(:body).merge(author_id: current_user.id)
    step.comments.create(comment_params)

    redirect_to position_recruitment_recruitment_step_path(step.recruitment.position, step.recruitment, step)
  end
end
