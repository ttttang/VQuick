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
      if(event.date_and_time>Time.now-5.hours)
        @events.push(event)
      end
    end

    #12 events per page
    @events=@events.paginate(:per_page => 12, :page=>params[:page])

    #checks to see if returning to the index in table view
    @return=params[:return]
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
    @event.name=capname.slice(0,1).capitalize + capname.slice(1..-1)
    
    caplocation=params[:event][:city_state]
    @event.city_state=caplocation.slice(0,1).capitalize + capname.slice(1..-1)


    if @event.save
      redirect_to myevents_path, notice: "Event was successfully created."
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
      flash[:notice]='Event updated.'
      redirect_to myevents_path
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to myevents_path
  end

  def show
    @allusers=@event.users
  end

  def myevents
    @myevents=[]
    @pastevents=[]

    #Display past events separately from current events
      current_user.events.each do |event|
        if event.date_and_time>Time.now-5.hours
          @myevents.push(event)
        else
          @pastevents.push(event)
        end
      end

    @myevents.sort_by!{ |k| k[:date_and_time]}.reverse!
    @pastevents.sort_by!{ |k| k[:date_and_time]}.reverse!
    #Find all events created by the user
    @createdevents=[]
    Event.search(params[:search]).each do |event|  
      if event.created_by == current_user.id&&event.date_and_time>Time.now
        @createdevents.push(event)
      end
    end 
    @createdevents.sort_by!{ |k| k[:date_and_time]}.reverse!
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
      params[:event].permit( :name, :description, :requirements, :date_and_time, :hours, :minutes, :category, :image, :street, :city_state, :zip)
  end

  #SORTING
  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "date_and_time"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
