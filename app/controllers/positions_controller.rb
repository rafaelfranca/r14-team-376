class PositionsController < ApplicationController
  before_action :check_permission

  def new
    @position = @organization.positions.build
  end

  def create
    position_params = params.require(:position).permit(:title, :name)
    @position = @organization.positions.build(position_params)

    if @position.save
      redirect_to @position, notice: 'Position successfully created.'
    else
      render 'new'
    end
  end

  def show
    @position = @organization.positions.find(params[:id])
  end

  private

  def check_permission
    @organization = Organization.find(params[:organization_id])

    if current_user.organization != @organization
      raise ActiveRecord::RecordNotFound
    end
  end
end
