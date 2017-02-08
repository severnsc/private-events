require 'test_helper'

class EventsDeleteTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@other_user = users(:archer)
		@event = events(:event)
	end

	test "delete without login and wrong user" do
		assert_no_difference 'Event.count' do
			delete event_path(@event)
		end
		assert_redirected_to login_path
		log_in_as(@other_user)
		assert_redirected_to user_path(@other_user)
		follow_redirect!
		assert_template 'users/show'
	end

	test "delete logged in as correct user" do
		log_in_as(@user)
		assert_difference 'Event.count', -1 do
			delete event_path(@event)
		end
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'users/show'
	end
end