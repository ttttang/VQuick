class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]

  def index
  	@organizations=Organization.search(params[:search])
  end

  def new
  	@organization=Organization.new
  end

  def create
    @organization = Organization.new(params[:organization].permit(:name, :website, :description, :contact, :phone, :email))
    
    if @organization.save
      redirect_to new_user_registration_path, notice: "Organization was successfully created."
    else
      render 'new'
    end

  end  
  

  def show
    allevents=Event.all
    allusers=@organization.users 
    @events=[]

    allevents.each do |event|
      allusers.each do |user|
        if event.created_by==user.id
          @events.push(event)
        end
      end
    end

  end

  def edit
    @organization=Organization.find(params[:id])
  end

  def update
    @organization=Organization.find(params[:id])
    if @organization.update(params[:organization].permit(:name, :company_id, :default_rate, :slug))
      flash[:notice]='Organization updated.'
      redirect_to @organization
    else
      render 'edit'
    end
  end

private
  def set_organization
  	@organization= Organization.find(params[:id])
  end

 #  def organization_params
	# params.require(:organization).permit(:name)
 #  end
end
