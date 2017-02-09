class InvitationsController < ApplicationController
	before_action :logged_in, only:[:index, :edit, :show, :destroy]
	before_action :correct_user, only:[:edit, :destroy, :show]

	def create
		@invitee = User.find_by_email(params[:invitation][:invitee_email])
		if @invitee
			@invitation = Invitation.new(invitation_params)
			@invitation.invitee_id = @invitee.id
			if @invitation.save
				flash[:success] = "Invitation sent!"
				redirect_to event_path(params[:invitation][:event_id])
			else
				flash[:danger] = "Bad rsvp"
				redirect_to event_path(params[:invitation][:event_id])
			end
		else
			flash[:danger] = "User not found"
			redirect_to event_path(params[:invitation][:event_id])
		end
	end

	def index
		@invitations = Invitation.all.pagiante(page: params[:page])
	end

	def edit
		@invitation = Invitation.find(params[:id])
		@event = @invitation.event
	end

	def update
		@invitee = User.find_by_email(params[:invitation][:invitee_email])
		@invitation = Invitation.find(params[:id])
		if @invitee
			@invitation.invitee_id = @invitee.id
			if @invitation.update_attributes(invitation_params)
				flash[:success] = "Invitation updated!"
				redirect_to event_path(params[:invitation][:event_id])
			else
				redirect_to event_path(params[:invitation][:event_id])
			end
		else
			flash.now[:danger] = "User not found"
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
		params.require(:invitation).permit(:event_id, :rsvp)
	end
end