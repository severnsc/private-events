class InvitationsController < ApplicationController
	before_action :logged_in, only:[:new, :index, :edit, :show, :destroy]
	before_action :correct_user, only:[:edit, :destroy, :show]

	def new
		@invitation = Invitation.new
	end

	def create
		@invitation = Invitation.new(invitation_params)
		if @invitation.save
			flash[:success] = "Invitation sent!"
			redirect_to event_path(@invitation.event_id)
		else
			render 'new'
		end
	end

	def index
		@invitations = Invitation.all.pagiante(page: params[:page])
	end

	def edit
		@invitation = Invitation.find(params[:id])
	end

	def update
		@invitation = Invitation.find(params[:id])
		if @invitation.update_attributes(invitation_params)
			flash[:success] = "Invitation updated!"
			redirect_to event_path(@invitation.event_id)
		else
			render 'edit'
		end
	end

	def show
		@invitation = Invitation.find(params[:id])
	end

	def destroy
		@invitation = Invitation.find(params[:id])
		@invitation.delete
		flash[:success] = "Invitation deleted!"
		redirect_to event_path(@invitation.event_id)
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
		@invitee = Invitation.find(params[:id]).invitee
		@host = Invitation.find(params[:id]).event.host
		redirect_to current_user unless current_user?(@invitee) || current_user?(@host)
	end

	def invitation_params
		params.require(:invitation).permit(:invitee_id, :event_id, :rsvp)
	end
end