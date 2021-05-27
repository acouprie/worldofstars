require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:LukeSkywalker)
    @planet = planets(:Pluton)
	end
	test "login with invalid information" do
		get root_path
		assert_template 'static_pages/home'
		post root_path, params: { session: { email: "", password: "" } }
		assert_template 'sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "login with valid information followed by logout" do
		get login_path
		post login_path, params: { session: { email: @user.email, password: 'password' } }
		assert is_logged_in?
		assert_redirected_to planet_url(@planet)
		follow_redirect!

		assert_template 'layouts/_header'
		assert_template 'layouts/_footer'
		assert_template 'layouts/application'
		assert_template 'planets/_caneva'
		assert_template 'planets/show'

		# nav menu
		assert_select "a[href=?]", root_path
		assert_select "a[href=?]", users_path
		assert_select "a[href=?]", contact_path
		assert_select "a[href=?]", user_path(@user)
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", signup_path, count: 0

		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		# Simulate a user clicking logout in a second window.
		delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", signup_path
		assert_select "a[href=?]", contact_path

		assert_select "a[href=?]", users_path, count: 0
		assert_select "a[href=?]", user_path(@user), count: 0
		assert_select "a[href=?]", logout_path,      count: 0
  end

	test "login with remembering" do
		log_in_as(@user, remember_me: '1')
		assert_not_empty cookies['remember_token']
	end

	test "login without remembering" do
		# Log in to set the cookie.
		log_in_as(@user, remember_me: '1')
		# Log in again and verify that the cookie is deleted.
		log_in_as(@user, remember_me: '0')
		assert_empty cookies['remember_token']
	end

end
