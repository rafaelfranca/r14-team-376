class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @organization = Organization.new
  end

  def create
    organization_params = params.require(:organization).permit(:name)
    @organization = Organization.new(organization_params)

    if @organization.save
      session['devise.organization_id'] = @organization.id
      redirect_to new_users_url
    else
      render 'new'
    end
  end

  def show
    @organization = Organization.find(params[:organization_id])

    if current_user.organization != @organization
      raise ActiveRecord::RecordNotFound
    end
  end
end
