require 'test_helper'

class PlanetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  MINIMUM_RESSOURCES = 1000

  def setup
    @planet = planets(:Terre)
    @champs = buildings(:champs)
    @champs.planet_id = @planet.id
  end

  test "should be valid" do
    assert @planet.valid?
  end

  test "should have buildings on creation" do
    planet = Planet.create(user_id: 1)
    assert planet.buildings.count == 5
  end

  test "should have minimum stocks" do
    bool_minimum_ressources = false
    if @planet.define_current_stock('food') == MINIMUM_RESSOURCES &&
       @planet.define_current_stock('metal') == MINIMUM_RESSOURCES &&
       @planet.define_current_stock('thorium') == MINIMUM_RESSOURCES
      bool_minimum_ressources = true
    end
    assert bool_minimum_ressources
  end

end
