require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.first
	end
   test "login with invalid information" do
		get root_path
		assert_template 'static_pages/home'
		post root_path, params: { session: { email: "", password: "" } }
		assert_template 'static_pages/home'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "login with valid information" do
		get root_path
		post root_path, params: { session: { email:
			@user.email, password: 'password' } }
		assert_redirected_to @user
		follow_redirect!
		assert_template 'static_pages/home'
		
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)
	end
end
