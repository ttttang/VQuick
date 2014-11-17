class EventsController < ApplicationController
 before_action :set_event, only: [:show]
 helper_method :sort_column, :sort_direction
  def index

  	@events= Event.order(sort_column+" "+sort_direction)
    @viewer=params[:listview]
  end

  def new
  	@event = Event.new
  end

  def show
  end

 
  def create
    
    @event = Event.new(params[:event].permit(:name, :description, :requirements, :date_and_time, :hours, :minutes, :organization_id))
    @event.organization_id = current_user.organization_id
    @event.created_by=current_user.id
    if @event.save
      redirect_to myevents_path, notice: "Event was successfully created."
    else
      render 'new'
    end

  end  

  def myevents
    @myevents=current_user.events

    @createdevents=[]
    
    Event.all.each do |event|  
      if event.created_by == current_user.id
        @createdevents.push(event)
      end
    end
     
  end

  def attend
    attendance=Attendance.new
    attendance.event_id=params[:attend]
    attendance.user_id=current_user.id
    if(attendance.save)
      redirect_to myevents_path, notice: "Attending event."
    else
      render Event.find(params[:attend])
    end
  end

  def destroy
    @event=Event.find(params[:id])
    @event.destroy
    redirect_to myevents_path

  end

  def edit
    @event=Event.find(params[:id])

  end

  def update

    @event=Event.find(params[:id])
    if @event.update(params[:event].permit(:name, :company_id, :default_rate, :slug))
      flash[:notice]='Event updated.'
      redirect_to myevents_path
    else
      render 'edit'
    end

  end

  def unattend
    event=Event.find(params[:unattend])
    event.users.delete(current_user)
    redirect_to myevents_path
  end

private
  def set_event
	 @event= Event.find(params[:id])
  end

  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "date_and_time"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
