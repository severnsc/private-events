require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "index when not logged in, then login" do
		get users_path
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to users_path
		follow_redirect!
		assert_template 'users/index'
		assert_select "a[href=?]", user_path(@user)
		assert_select "div.pagination", count:2
	end
end