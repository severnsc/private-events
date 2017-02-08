require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:chris)
  	@other_user = users(:archer)
  	@invitation = @user.events.first.invitations.build(invitee_id:@other_user.id, rsvp: "no response")
  end

  test "invitation should be valid" do
  	assert @invitation.valid?
  end

  test "invitation should have an invitee_id" do
  	@invitation.invitee_id = " "
  	assert_not @invitation.valid?
  end

  test "invitation should have an event_id" do
  	@invitation.event_id = " "
  	assert_not @invitation.valid?
  end

  test "invitation should have an rsvp" do
  	@invitation.rsvp = " "
  	assert_not @invitation.valid?
  end
end
