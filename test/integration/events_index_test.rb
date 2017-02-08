require 'test_helper'

class EventsIndexTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "index when logged in" do
		get events_path
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to events_path
		follow_redirect!
		assert_template 'events/index'
		assert_select 'div.pagination', count:2
	end
end