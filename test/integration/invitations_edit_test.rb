require 'test_helper'

class InvitationsEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@invitation = invitations(:invite)
		@invitee = User.find(@invitation.invitee_id)
	end

	test "submitting with invalid information as host" do
		get edit_invitation_path(@invitation)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to edit_invitation_path(@invitation)
		follow_redirect!
		assert_template 'invitations/edit'
		assert_select 'form[action=?]', invitation_path(@invitation)
		assert_select 'input[name="invitation[invitee_email]"]'
		#Invalid email
		email = "1234@me.com"
		patch invitation_path(@invitation), params: { invitation: { invitee_email: email,
																	event_id: @invitation.event_id,
																	rsvp: @invitation.rsvp}}
		assert_equal @invitation.invitee_id, @invitation.reload.invitee_id
		assert_not flash.empty?
		assert_template 'invitations/edit'
		#Invalid event id
		event_id = "bad id"
		patch invitation_path(@invitation), params: { invitation: { invitee_email: @invitee.email,
																	event_id: event_id,
																	rsvp: @invitation.rsvp}}
		assert_equal @invitation.event_id, @invitation.reload.event_id
		assert_redirected_to event_path(event_id)
		follow_redirect!
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_template 'users/show'
		get edit_invitation_path(@invitation)
		assert_template 'invitations/edit'
		#Invalid rsvp
		patch invitation_path(@invitation), params: { invitation: { invitee_email: @invitee.email,
																	event_id: @invitation.event_id,
																	rsvp: ""}}
		assert_equal @invitation.rsvp, @invitation.reload.rsvp
		assert_redirected_to event_path(@invitation.event_id)
		follow_redirect!
		assert_template 'events/show'
	end

	test "submitting with valid information as host" do
		log_in_as(@user)
		get edit_invitation_path(@invitation)
		assert_template 'invitations/edit'
		assert_select 'form[action=?]', invitation_path(@invitation)
		assert_select 'input[name="invitation[invitee_email]"]'
		patch invitation_path(@invitation), params: { invitation: { invitee_email: @invitee.email,
																	event_id: @invitation.event_id,
																	rsvp: "Going"}}
		assert_equal "Going", @invitation.reload.rsvp
		assert_redirected_to event_path(@invitation.event_id)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
	end

	test "submitting with valid information as invitee" do
		log_in_as(@invitee)
		get edit_invitation_path(@invitation)
		assert_template 'invitations/edit'
		assert_select 'form[action=?]', invitation_path(@invitation)
		assert_select 'input[name="invitation[invitee_email]"]', count:0
		patch invitation_path(@invitation), params: { invitation: { invitee_email: @invitee.email,
																	event_id: @invitation.event_id,
																	rsvp: "Going"}}
		assert_equal "Going", @invitation.reload.rsvp
		assert_redirected_to event_path(@invitation.event_id)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
	end
end