require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @planet = planets(:Terre)
    @champs = buildings(:champs)
  end

  test "should get new farm" do
    assert_difference('Building.count') do
      @user.planets.first.create_farm
    end
  end
end
