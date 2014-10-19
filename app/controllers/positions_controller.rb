class PositionsController < ApplicationController
  def new
    @position = current_user.organization.positions.build
  end

  def create
    position_params = params.require(:position).permit(:title, :name)
    @position = current_user.organization.positions.build(position_params)

    if @position.save
      redirect_to @position, notice: 'Position successfully created.'
    else
      render 'new'
    end
  end

  def show
    @position = current_user.organization.positions.find(params[:id])
  end
end
