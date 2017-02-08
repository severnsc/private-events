require 'test_helper'

class NewEventTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "submitting with invalid information" do
		get new_event_path
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to new_event_path
		follow_redirect!
		assert_template 'events/new'
		assert_no_difference 'Event.count' do
			post events_path, params: { event: { name:"",
												 date: "",
												 location: "",
												 host_id: ""}}
		end
		assert_template 'events/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert'
	end

	test "submitting with valid information" do
		log_in_as(@user)
		get new_event_path
		assert_template 'events/new'
		assert_difference 'Event.count', 1 do
			post events_path, params: { event: { name: "Test Event",
												 date: Time.zone.now,
												 location: "my house",
												 host_id: @user.id}}
		end
		@event = Event.find_by(name: "Test Event")
		assert_redirected_to event_path(@event)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
	end
end