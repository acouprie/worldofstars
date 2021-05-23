require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @planet = planets(:Terre)
  end
end
