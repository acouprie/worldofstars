require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @other_user = users(:ObiWan)
    @planet = planets(:Terre)
  end

  test "should build new farm" do
    puts @user.planets.first.buildings.inspect
    assert_difference('Building.count') do
      @user.planets.first.create_farm
    end
  end

  test "should not build same building multiple times" do
    assert_difference('Building.count') do
      @user.planets.first.create_farm
    end
    assert_no_difference('Building.count') do
      @user.planets.first.create_farm
    end
  end
end
