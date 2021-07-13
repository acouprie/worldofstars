require 'test_helper'

class PlanetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @other_user = users(:ObiWan)
    @planet = planets(:Terre)
    @other_planet = planets(:Venus)
  end

  test "should get planet" do
    log_in_as(@user)
    get planet_url(@planet)
    assert_select "title", "Terre | World of Stars"
    assert planet_url(@planet.name)
  end

  test "should not get other player planet" do
    log_in_as(@user)
    get planet_url(@other_planet)
    !follow_redirect!
    assert_select "title", "Terre | World of Stars"
    assert planet_url(@planet)
  end
end
