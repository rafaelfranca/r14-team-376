class PositionsController < ApplicationController
  def new
    @position = current_user.organization.positions.build
  end

  def create
    position_params = params.require(:position).permit(:title, :name)
    @position = current_user.organization.positions.build(position_params)

    # TODO: permit with strong parameters
    steps_template = params[:steps_template].values.delete_if { |step|
      step['order'].blank? || step['title'].blank? || step['description'].blank?
    }
    @position.steps_template = steps_template

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
