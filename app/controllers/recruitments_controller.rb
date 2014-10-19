class RecruitmentsController < ApplicationController
  def show
    position = current_user.organization.positions.find(params[:position_id])
    @recruitment = position.recruitments.find(params[:id])
  end
end
