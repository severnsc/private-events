require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	test "signup path should get new user" do
		get signup_path
		assert_template 'users/new'
	end
end
