require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "World of Stars"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Accueil | #{@base_title}"
  end

  test "should get sign_up" do
    get signup_path
    assert_response :success
    assert_select "title", "Enregistrement | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
