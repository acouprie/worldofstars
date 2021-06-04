require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Frodo)
    @other_user = users(:ObiWan)
    @planet = planets(:Terre)
    @headquarter = buildings(:headquarter)
    @solar = buildings(:solar)
    @farm = buildings(:farm)
  end

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
    Resque.remove_delayed(TimeToBuild, 1)
  end

  test "should not upgrade not log in" do
    post building_upgrade_path, params: {id: 9999, format: :js}
    assert_redirected_to login_url
  end

  test "should upgrade" do
    log_in_as(@user)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Bâtiment en cours de construction !", flash[:success]
  end

  test "should not upgrade multiple" do
    log_in_as(@user)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Bâtiment en cours de construction !", flash[:success]
    post building_upgrade_path, params: {id: @solar.id, format: :js}
    assert_equal "Un bâtiment est déjà en cours d'amélioration.", flash[:warning]
  end

  test "should display error if building is nil upgrade" do
    log_in_as(@user)
    post building_upgrade_path, params: {id: 9999, format: :js}
    assert_equal "Erreur 0x01, contactez l'administrateur avec ce code.", flash[:danger]
    follow_redirect!
    assert_redirected_to planet_url(@user.id)
  end

  test "should display error if building is nil cancel" do
    log_in_as(@user)
    post building_cancel_path, params: {id: 9999, format: :js}
    assert_equal "Erreur 0x02, contactez l'administrateur avec ce code.", flash[:danger]
    follow_redirect!
    assert_redirected_to planet_url(@user.id)
  end

  test "should upgrade headquarter first" do
    log_in_as(@user)
    @headquarter.update(lvl: 0)
    post building_upgrade_path, params: {id: @solar.id, format: :js}
    assert_equal "Améliorez d'abord le Centre de commandemant !", flash[:warning]
  end

  test "should not upgrade already upgrading" do
    log_in_as(@user)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Bâtiment en cours de construction !", flash[:success]
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Ce bâtiment est déjà en cours d'amélioration", flash[:warning]
  end

  test "should not upgrade other player building" do
    log_in_as(@other_user)
    post building_upgrade_path, params: {id: @headquarter.id, format: :js}
    follow_redirect!
    assert_redirected_to planet_url(@other_user.id)
  end

  test "should not upgrade energy" do
    log_in_as(@user)
    @solar.update(production: 21)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Energie insuffisante", flash[:warning]
    @solar.update(lvl: 1, conso_power: 46)
    @solar.update(production: 45)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Energie insuffisante", flash[:warning]
  end

  test "should upgrade energy" do
    log_in_as(@user)
    @solar.update(production: 22)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Bâtiment en cours de construction !", flash[:success]
  end

  test "should not upgrade resources" do
    log_in_as(@user)
    @planet.update(total_food_stock: 0)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Nous manquons de ressources", flash[:warning]
  end

  test "should upgrade resources" do
    log_in_as(@user)
    @planet.update(total_food_stock: 50, total_metal_stock: 60)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Bâtiment en cours de construction !", flash[:success]
  end

  test "should not cancel not upgrading" do
    log_in_as(@user)
    post building_cancel_path, params: {id: @headquarter.id, format: :js}
    assert_equal "Le bâtiment n'est pas en amélioration", flash[:warning]
  end

  test "should cancel upgrading" do
    log_in_as(@user)
    post building_upgrade_path, params: {id: @farm.id, format: :js}
    assert_equal "Bâtiment en cours de construction !", flash[:success]
    post building_cancel_path, params: {id: @farm.id, format: :js}
    assert_equal "L'amélioration du bâtiment est annulée", flash[:success]
  end
end
