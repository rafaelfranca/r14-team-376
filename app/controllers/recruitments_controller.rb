class RecruitmentsController < ApplicationController
  def show
    @recruitment = Recruitment.find(params[:id])
  end
end
