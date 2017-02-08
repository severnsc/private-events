require 'test_helper'

class EventsEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@other_user = users(:archer)
		@event = events(:event)
	end

	test "edit with invalid information" do
		get edit_event_path(@event)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to edit_event_path(@event)
		follow_redirect!
		assert_template 'events/edit'
		patch event_path(@event), params: { event: { name: "",
													date: "",
													location: "",
													host_id: @user.id}}
		assert_equal @event.name, @event.reload.name
		assert_template 'events/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert'
	end

	test "edit with valid information" do
		log_in_as(@user)
		get edit_event_path(@event)
		assert_template 'events/edit'
		patch event_path(@event), params: { event: { name: "Test Event",
													 date: Time.zone.now,
													 location: "home",
													 host_id: @user.id}}
		assert_equal "Test Event", @event.reload.name
		assert_redirected_to event_path(@event)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
	end

	test "edit as wrong user" do
		log_in_as(@other_user)
		get edit_event_path(@event)
		assert_redirected_to user_path(@other_user)
		follow_redirect!
		assert_template 'users/show'
	end
end