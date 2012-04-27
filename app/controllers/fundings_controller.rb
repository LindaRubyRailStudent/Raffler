class FundingsController < ApplicationController
  respond_to :json

  def index
    respond_with Funding.all
  end

  def show
    respond_with Funding.find(params[:id])
  end

  def create
    respond_with Funding.create(params[:entry])
  end

  def update
    respond_with Funding.update(params[:id], params[:entry])
  end

  def destroy
    respond_with Funding.destroy
  end
end
