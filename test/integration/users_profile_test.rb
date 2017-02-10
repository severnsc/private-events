require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@event = events(:event)
		@event2 = events(:event2)
	end

	test "profile page should show all associated events" do
		get user_path(@user)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_template 'users/show'
		assert_select 'div#hosted_events'
		assert_select 'a[href=?]', event_path(@event), count:1
		assert_select 'a[href=?]', event_path(@event2), count:1
		assert_select 'div#events_going_to'
		assert_select 'div#need_rsvp'
	end
end