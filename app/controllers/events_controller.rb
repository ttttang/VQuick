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
    @event = Event.new(params[:event].permit(:name, :description, :requirements, :date_and_time, :hours, :minutes))
    @event.save
    redirect_to @event
  end  

  def myevents
    @events=current_user.events
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
