require 'test_helper'

class EventsShowTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@archer = users(:archer)
		@event = events(:event)
		@invitation = invitations(:invite2)
	end

	test "events page should display all invites and attendees" do
		get event_path(@event)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to event_path(@event)
		follow_redirect!
		assert_template 'events/show'
		assert_select 'form[action=?]', invitations_path
		assert_select 'a[href=?]', invitation_path(@invitation)
		assert_select 'a[href=?]', user_path(@archer), count:2
	end
end