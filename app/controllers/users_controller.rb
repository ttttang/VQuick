class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!
  
  def index
  	@users= User.all
  end

  def new
  	@user = User.new
  end

  def show
  end

private
  def set_user
	@user= User.find(params[:id])
  end
end
