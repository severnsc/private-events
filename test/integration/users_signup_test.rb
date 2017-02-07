require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "signup with invalid information" do
		get signup_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post signup_path, params: { user: { email: "",
												name: "",
												password: "",
												password_confirmation: ""}}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert'
	end

	test "signup with valid information" do
		get signup_path
		assert_template 'users/new'
		assert_difference 'User.count', 1 do
			post signup_path, params: { user: { email: "user@example.com",
												name: "user",
												password: "password",
												password_confirmation: "password"}}
		end
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
		assert is_logged_in?
	end
end