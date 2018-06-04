require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @other_user = users(:ObiWan)
    @planet = planets(:Terre)
  end
end
