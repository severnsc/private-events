require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:chris)
  	@event = Event.new(name: "Example event", date: Time.zone.now, location: "My house", host_id: @user.id)
  end

  test "event should be valid" do
  	assert @event.valid?
  end

  test "event should have a name" do
  	@event.name = "  "
  	assert_not @event.valid?
  end

  test "event name should be 30 chars or less" do
  	@event.name = "A"*31
  	assert_not @event.valid?
  end

  test "event should have a date" do
  	@event.date = "  "
  	assert_not @event.valid?
  end

  test "event should have a location" do
  	@event.location = "  "
  	assert_not @event.valid?
  end

  test "event location should be 255 chars or less" do
  	@event.location = "A"*256
  	assert_not @event.valid?
  end

  test "event should have a host" do
  	@event.host_id = "  "
  	assert_not @event.valid?
  end
end
