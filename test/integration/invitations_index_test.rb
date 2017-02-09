require 'test_helper'

class InvitationsIndexTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@event = events(:event)
		@other_event = events(:event3)
	end

	test "Invitations path login redirect and pagination check" do
		get invitations_path
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to invitations_path
		follow_redirect!
		assert_template 'invitations/index'
		assert_select 'div.pagination', count:2
	end

	test "invitations path should only show your own invitations" do
		log_in_as(@user)
		get invitations_path
		assert_template 'invitations/index'
		assert_select 'div.pagination', count:2
		assert_select 'a[href=?]', event_path(@event)
		assert_select 'a[href=?]', event_path(@other_event), count:0
	end
end