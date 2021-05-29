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
    @overpriced = buildings(:overpriced)
    @power_abuse = buildings(:power_abuse)
  end
  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
    Resque.remove_delayed(TimeToBuild, 1)
  end

  test "should upgrade" do
    current_lvl = @headquarter.lvl
    @headquarter.upgrade
    assert @headquarter.lvl == current_lvl + 1
  end
end
