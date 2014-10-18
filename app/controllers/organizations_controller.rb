class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params.require(:organization).permit(:name))

    if @organization.save
      redirect_to root_url
    else
      render 'new'
    end
  end
end
