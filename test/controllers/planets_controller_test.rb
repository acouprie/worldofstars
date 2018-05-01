require 'test_helper'

class PlanetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @planet = planets(:Terre)
  end

  test "should redirect login get new when not logged in" do
    get new_planet_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect login create planet when not logged in" do
    assert_no_difference('Planet.count') do
      post planets_url, params: { planet: { name: @planet.name, user_id: @user.id } }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect login show planet when not logged in" do
    get planet_url(@planet)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect login get edit when not logged in" do
    get edit_planet_url(@planet)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
