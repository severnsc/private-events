require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@invitation = invitations(:invite)
	end

	test "index should redirect unless logged in" do
		get invitations_path
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to invitations_path
		follow_redirect!
		assert_template 'invitations/index'
	end

	test "edit should redirect unless logged in" do
		get edit_invitation_path(@invitation)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to edit_invitation_path(@invitation)
		follow_redirect!
		assert_template 'invitations/edit'
	end

	test "show should redirect unless logged in" do
		get invitation_path(@invitation)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to invitation_path(@invitation)
		follow_redirect!
		assert_template 'invitations/show'
	end

	test "destroy should redirect unless logged in" do
		delete invitation_path(@invitation)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to user_path(@user)
		delete invitation_path(@invitation)
		assert_redirected_to event_path(@invitation.event_id)
		follow_redirect!
		assert_not flash.empty?
		assert_template 'events/show'
	end
end
