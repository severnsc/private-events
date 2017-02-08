class EventsController < ApplicationController
	before_action :logged_in, only: [:new, :index, :show, :edit, :destroy]
	before_action :correct_user, only: [:edit, :destroy]

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:success] = "Event created!"
			redirect_to @event
		else
			render 'new'
		end
	end

	def index
		@events = Event.all.paginate(page: params[:page])
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(event_params)
			flash[:success] = "Event updated!"
			redirect_to @event
		else
			render 'edit'
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.delete
		redirect_to current_user
	end

	private

	def logged_in
		unless logged_in?
			store_location
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def correct_user
		@user = Event.find(params[:id]).host
		redirect_to current_user unless current_user?(@user)
	end

	def event_params
		params.require(:event).permit(:name, :date, :location, :host_id)
	end

end
