class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]

  def index
  	@organizations=Organization.all
  end

  def new
  	@organization=Organization.new
  end

  def create
    @organization = Organization.new(params[:organization].permit(:name, :description, :contact, :phone, :email, :website))
    @organization.save
    redirect_to new_user_registration_path
  end  

  def show
  end

private
  def set_organization
  	@organization= Organization.find(params[:id])
  end

 #  def organization_params
	# params.require(:organization).permit(:name)
 #  end
end
