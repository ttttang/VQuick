class EventsController < ApplicationController
 before_action :set_event, only: [:show, :destroy, :edit, :update]
 before_action :authenticate_user!, except: [:index, :show] #Only users can access other actions
 helper_method :sort_column, :sort_direction #For sorting
  

  def index
    #Events will be displayed by newest time
    #sort events by descending date
  	allevents= Event.search(params[:search]).order(sort_column+" "+sort_direction)
    @events=[]
    allevents.each do |event|
      if(event.date_and_time>Time.now.in_time_zone("Pacific Time (US & Canada)")-event.hours.hours)
        @events.push(event)
      end
    end

    #12 events per page
    @events=@events.paginate(:per_page => 12, :page=>params[:page])

    
  end

  def new
  	@event = Event.new
  end

  def create    
    @event = Event.new(event_params)
    @event.organization_id = current_user.organization_id
    
    #Link the event to the user who created it
    @event.created_by=current_user.id
    
    #Capitalize the event name and city/state before saving them to the event       
      capname=params[:event][:name]
      unless capname==nil||capname==""
        @event.name=capname.slice(0,1).capitalize + capname.slice(1..-1)
      end

      caplocation=params[:event][:city_state]
      unless caplocation==nil||caplocation=""
        @event.city_state=caplocation.slice(0,1).capitalize + capname.slice(1..-1)
      end

    if @event.save
      redirect_to createdevents_path, notice: "Event was successfully created."
    else
      render 'new'
    end
  end  

  def edit
    #only the person who created the event can edit it
    if current_user.id!=@event.created_by
      redirect_to myevents_path
    end

  end

  def update
    if @event.update(event_params)
      redirect_to createdevents_path, notice: "Event was successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    if action_name==index  
      redirect_to events_path
    else
      redirect_to createdevents_path
    end
  end

  def show
    @allusers=@event.users
  end

  def createdevents
    #Find all events created by the user
    @createdevents=[]
    Event.search(params[:search]).each do |event|  
      if event.created_by == current_user.id&&event.date_and_time>Time.now.in_time_zone("Pacific Time (US & Canada)")
        @createdevents.push(event)
      end
    end 
    @createdevents.sort_by!{ |k| k[:date_and_time]}
    @createdevents=@createdevents.paginate(:per_page => 12, :page=>params[:page])
  end
  

  def myevents
    @myevents=[]
    @pastevents=[]

    #Display past events separately from current events
      current_user.events.search(params[:search]).each do |event|
        if event.date_and_time>Time.now.in_time_zone("Pacific Time (US & Canada)")-event.hours.hours
          @myevents.push(event)
        else
          @pastevents.push(event)
        end
      end

    @myevents.sort_by!{ |k| k[:date_and_time]}
    @pastevents.sort_by!{ |k| k[:date_and_time]}.reverse!
    @myevents=@myevents.paginate(:per_page => 12, :page=>params[:page])
    @pastevents=@pastevents.paginate(:per_page => 12, :page=>params[:page])
  end

  def attend
    #Joins user to event (attending an event)
    attendance=Attendance.new
    attendance.event_id=params[:attend]
    attendance.user_id=current_user.id
    if(attendance.save)
      redirect_to myevents_path, notice: "Attending event."
    else
      render Event.find(params[:attend])
    end
  end


  def unattend
    #removes event from user
    event=Event.find(params[:unattend])
    event.users.delete(current_user)
    redirect_to myevents_path
  end

private
  def set_event
	 @event= Event.find(params[:id])
  end

  def event_params
      params.require(:event).permit( :name, :description, :requirements, :date_and_time, :hours, :minutes, :category, :image, :street, :city_state, :zip)
  end

  #SORTING
  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "date_and_time"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
