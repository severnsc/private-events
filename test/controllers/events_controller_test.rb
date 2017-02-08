require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:chris)
  	@other_user = users(:archer)
  	@event = events(:event)
  end

  test "get new should redirect unless logged in" do
  	get new_event_path
  	assert_redirected_to login_path
  	log_in_as(@user)
  	assert_redirected_to new_event_path
  	follow_redirect!
  	assert_template 'events/new'
  end

  test "get index should redirect unless logged in" do
  	get events_path
  	assert_redirected_to login_path
  	log_in_as(@user)
  	assert_redirected_to events_path
  	follow_redirect!
  	assert_template 'events/index'
  end

  test "get show should redirect unless logged in" do
  	get event_path(@event)
  	assert_redirected_to login_path
  	log_in_as(@user)
  	assert_redirected_to event_path(@event)
  	follow_redirect!
  	assert_template 'events/show'
  end

  test "get edit should redirect unless logged in and correct user" do
  	get edit_event_path(@event)
  	assert_redirected_to login_path
  	log_in_as(@other_user)
  	assert_redirected_to user_path(@other_user)
  	log_in_as(@user)
  	get edit_event_path(@event)
  	assert_template 'events/edit'
  end

  test "destroy should redirect unless logged in and correct user" do
  	delete event_path(@event)
  	assert_redirected_to login_path
  	log_in_as(@other_user)
  	assert_redirected_to user_path(@other_user)
  	log_in_as(@user)
  	delete events_path(@event)
  	assert_redirected_to user_path(@user)
  	assert_not flash.empty?
  end
end
