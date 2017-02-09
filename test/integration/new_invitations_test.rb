require 'test_helper'

class NewInvitationsTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@invitee = users(:archer)
		@event = events(:event)
	end

	test "submitting invalid info" do
		log_in_as(@user)
		get event_path(@event)
		assert_template 'events/show'
		assert_select 'form[action=?]', invitations_path
		#Invalid email
		assert_no_difference 'Invitation.count' do
			post invitations_path, params: { invitation: { invitee_email: "1234@me.com",
															event_id: @event.id,
															rsvp: "no response"}}
		end
		assert_redirected_to event_path(@event)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
		assert_select 'div.invitation', count:0
		#Invalid event_id
		assert_no_difference 'Invitation.count' do
			post invitations_path, params: { invitation: { invitee_email: @invitee.email,
															event_id: "bad id",
															rsvp: "no response"}}
		end
		assert_redirected_to event_path("bad id")
		follow_redirect!
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'users/show'
		get event_path(@event)
		#Invalid rsvp
		assert_no_difference 'Invitation.count' do
			post invitations_path, params: { invitation: { invitee_email: @invitee.email,
															event_id: @event.id,
															rsvp: ""}}
		end
		assert_redirected_to event_path(@event)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
	end

	test "submitting valid invitee email" do
		log_in_as(@user)
		get event_path(@event)
		assert_template 'events/show'
		assert_select 'form[action=?]', invitations_path
		assert_difference 'Invitation.count', 1 do
			post invitations_path, params: { invitation: { invitee_email: @invitee.email,
															event_id: @event.id,
															rsvp: "no response"}}
		end
		assert_redirected_to event_path(@event)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
		assert_select 'div.invitation', count:1
	end
end