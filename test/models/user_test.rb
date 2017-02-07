require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
 def setup
 	@user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
 end

 test "user should be valid" do
 	assert @user.valid?
 end

 test "user name shouldn't be empty" do
 	@user.name = "   "
 	assert_not @user.valid?
 end

 test "user email shouldn't be empty" do
 	@user.email = "    "
 	assert_not @user.valid?
 end

 test "user email should be valid" do
 	invalid_emails = %w[test@me testatme.com get@me.com. @hello@me.com 1234@this.com@me]
 	invalid_emails.each do |email|
 		@user.email = email
 		assert_not @user.valid?, "#{email} should not be valid"
 	end
 end

 test "user password should be present" do
 	@user.password = ""
 	@user.password_confirmation = ""
 	assert_not @user.valid?
 end

 test "user password should be at least 8 chars" do
 	@user.password = "a"*7
 	assert_not @user.valid?
 end

 test "email should be saved as all downcase" do
 	mixed_case_email = "UsEr@ExAmPlE.CoM"
 	@user.email = mixed_case_email
 	assert @user.valid?
 	@user.save
 	assert_equal mixed_case_email.downcase, @user.reload.email
 end
end