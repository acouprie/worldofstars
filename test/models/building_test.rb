require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @planet = planets(:Terre)
    @solar = buildings(:solar)
    @solar.planet_id = @planet.id
    @champs = buildings(:champs)
    @champs.planet_id = @planet.id
    @overpriced = buildings(:overpriced)
    @overpriced.planet_id = @planet.id
    @power_abuse = buildings(:power_abuse)
    @power_abuse.planet_id = @planet.id
  end

  test "should upgrade" do
    current_lvl = @solar.lvl
    @solar.upgrade
    assert @solar.lvl == current_lvl + 1
  end

  test "should not upgrade : lack of power" do
    current_lvl = @power_abuse.lvl
    @power_abuse.update(conso_power: @power_abuse.conso_power)
    assert_not @power_abuse.lvl == current_lvl + 1
  end

  test "should not upgrade : lack of ressources" do
    current_lvl = @overpriced.lvl
    @overpriced.update(food_price: @overpriced.food_price,
                       metal_price: @overpriced.metal_price,
                       thorium_price: @overpriced.thorium_price)
    assert_not @overpriced.lvl == current_lvl + 1
  end
end
