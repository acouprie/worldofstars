require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @other_user = users(:ObiWan)
    @planet = planets(:Terre)
  end

  test "should build new farm" do
    assert_difference('Building.count') do
      @user.planets.first.create_solar
    end
  end

  test "should not build same building multiple times" do
    assert_difference('Building.count') do
      @user.planets.first.create_solar
    end
    assert_no_difference('Building.count') do
      @user.planets.first.create_solar
    end
  end

  test "should check power availability" do
    assert_no_difference('Building.count') do
      @user.planets.first.create_farm
    end
    assert_difference('Building.count') do
      @user.planets.first.create_solar
    end
    assert_difference('Building.count') do
      @user.planets.first.create_farm
    end
  end
end
