require 'test_helper'

class PlanetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @planet = planets(:Terre)
  end

end
