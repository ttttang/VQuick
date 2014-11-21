class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  	@organizations=Organization.search(params[:search])
  end

  def new
  	@organization=Organization.new
  end

  def create
    @organization = Organization.new(params[:organization].permit(:name, :website, :description, :contact, :phone, :email, :code, :image))
    
    if @organization.save
      redirect_to new_user_registration_path, notice: "Organization was successfully created."
    else
      render 'new'
    end

  end  
  
  def edit
  end

  def update
    
    if @organization.update(params[:organization].permit(:name, :website, :description, :contact, :phone, :email, :image))
      flash[:notice]='Organization updated.'
      redirect_to @organization
    else
      render 'edit'
    end
  end

  def show
    allevents=Event.all
    allusers=@organization.users 
    events=[]

    allevents.each do |event|
      allusers.each do |user|
        if event.created_by==user.id
          events.push(event)
        end
      end
    end

    @currentevents=[]
    @pastevents=[]
    #Separate current events from past events for selected organization
    events.each do |event|
      if event.date_and_time>Time.now.in_time_zone("Pacific Time (US & Canada)")
        @currentevents.push(event)
        #Sort events by date
        @currentevents.sort_by!{ |k| k[:date_and_time]}.reverse!
      else
        @pastevents.push(event)
        @pastevents.sort_by!{ |k| k[:date_and_time]}.reverse!
      end
    end
    

      
      
    
  end
  
private
  def set_organization
  	@organization= Organization.find(params[:id])
  end

  def organization_params
	   @params.require(:organization).permit(:name)
  end
end
