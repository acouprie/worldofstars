require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  	test "layout links" do
		get root_path
		assert_template 'layouts/application.html.erb'
		assert_select "a[href=?]", root_path
		assert_select "a[href=?]", register_path
		assert_select "a[href=?]", contact_path
	end
end
