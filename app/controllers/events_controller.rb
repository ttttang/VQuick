class EventsController < ApplicationController
 before_action :set_event, only: [:show]
 
  def index
  	@events= Event.all
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

private
  def set_event
	 @event= Event.find(params[:id])
  end
end
