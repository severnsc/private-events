require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
		@other_user = users(:archer)
	end

	test "signup path should get new user" do
		get signup_path
		assert_template 'users/new'
	end

	test "should redirect user show unless logged in" do
		get user_path(@user)
		assert_redirected_to login_url
		follow_redirect!
		assert_not flash.empty?
		log_in_as(@user)
		get user_path(@user)
		assert_template 'users/show'
	end

	test "should redirect users index unless logged in" do
		get users_path
		assert_redirected_to login_url
		follow_redirect!
		assert_not flash.empty?
		log_in_as(@user)
		get users_path
		assert_template 'users/index'
	end

	test "should redirect users edit unless logged in" do
		get edit_user_path(@user)
		assert_redirected_to login_url
		follow_redirect!
		assert_not flash.empty?
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
	end

	test "should redirect users edit unless logged in as correct user" do
		log_in_as(@other_user)
		get edit_user_path(@user)
		assert_redirected_to user_path(@other_user)
	end

	test "should redirect destroy unless logged in" do
		delete user_path(@user)
		assert_redirected_to login_url
		follow_redirect!
		assert_not flash.empty?
	end
end
