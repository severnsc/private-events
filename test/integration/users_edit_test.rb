require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "editing user with invalid information" do
		get edit_user_path(@user)
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		follow_redirect!
		assert_template 'users/edit'
		patch user_path, params: { user: { name: "",
											email: "severnsc@gmail",
											password: "password",
											password_confirmation: "notpassword"}}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert'
		assert_equal @user.email, @user.reload.email
	end

	test "editing user with valid information" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		email = "chris@me.com"
		patch user_path, params: { user: { name: @user.name,
											email: email,
											password: "",
											password_confirmation: ""}}
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
		assert_equal email, @user.reload.email
	end
end