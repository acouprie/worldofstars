require 'test_helper'
class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:Frodo)
    @non_admin = users(:ObiWan)
    @non_activated = users(:JohnSnow)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'

    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      if user.activated == true
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "should not display unactivated account" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: @non_activated.name, count: 0
  end
end
