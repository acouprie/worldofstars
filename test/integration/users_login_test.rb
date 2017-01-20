require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
   test "login with invalid information" do
		get root_path
		assert_template 'static_pages/home'
		post root_path, params: { session: { email: "", password: "" } }
		assert_template 'static_pages/home'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end
end
