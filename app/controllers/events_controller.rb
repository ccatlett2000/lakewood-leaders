class EventsController < ApplicationController
  respond_to :html, :json

  def index
    @events = Event.all
    respond_with @events
  end

  def show
    @event = Event.find_by_id(params[:id])
    if @event
      respond_with @event
    else
      respond_to do |format|
        format.html { not_found }
        format.json { head status: :not_found }
      end
    end
  end

  def new
    @event = Event.new
    respond_to :html
  end

  def edit
    @event = Event.find_by_id(params[:id])
    if @event
      respond_with @event
    else
      respond_to do |format|
        format.html { not_found }
        format.json { head status: :not_found }
      end
    end
  end

  def create
    if session[:user_id].nil?
      head status: :forbidden and return
    end
    if !User.find_by_id(session[:user_id]).is_admin
      head status: :forbidden and return
    end
    event = Event.new(event_parameters_create)
    if event.save
      head status: :created, location: event_path(event)
    else
      render json: {error: event.errors}, status: :bad_request
    end
  end

  def update
    event = Event.find_by_id(params[:id])
    if !event
      head status: :not_found and return
    end
    if session[:user_id].nil? or !User.find_by_id(session[:user_id]).is_admin
      head status: :forbidden and return
    end
    if event.update(event_parameters_update)
      head status: :ok
    else
      render json: {error: event.errors}, status: :bad_request
    end
  end

  def destroy
    event = Event.find_by_id(params[:id])
    if !event
      head status: :not_found and return
    end
    if session[:user_id].nil? or !User.find_by_id(session[:user_id]).is_admin
      head status: :forbidden and return
    end
    event.destroy
    head status: :ok
  end

  private

  def event_parameters_create
    parameters = params.require(:event).permit(:name, :description, :location, :start_time, :end_time, :max_participants)
    parameters[:finished] = false
    return parameters
  end

  def event_parameters_update
    params.require(:event).permit(:name, :description, :location, :start_time, :end_time, :finished, :max_participants)
  end
end