require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @planet = planets(:Terre)
    @headquarter = buildings(:headquarter)
    @solar = buildings(:solar)
    @farm = buildings(:farm)
  end
  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
    Resque.remove_delayed(BuildingUpgrade, 1)
  end

  test "should upgrade" do
    current_lvl = @farm.lvl
    @farm.set_position(1)
    assert @farm.position == 1
    @farm.upgrade
    assert @farm.lvl == current_lvl + 1
  end

  test "should not upgrade without position" do
    current_lvl = @farm.lvl
    @farm.upgrade
    assert @farm.lvl == current_lvl
  end

  test "should set position" do
    assert @farm.position.nil?
    @farm.set_position(1)
    assert @farm.position == 1
  end

  test "should not set position already position" do
    @headquarter.set_position(2)
    assert @headquarter.position == 1
  end
end
