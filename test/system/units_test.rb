require "application_system_test_case"

class UnitsTest < ApplicationSystemTestCase
  setup do
    @unit = units(:one)
  end

  test "visiting the index" do
    visit units_url
    assert_selector "h1", text: "Units"
  end

  test "creating a Unit" do
    visit units_url
    click_on "New Unit"

    fill_in "Attack", with: @unit.attack
    fill_in "Capacity", with: @unit.capacity
    fill_in "Defense", with: @unit.defense
    fill_in "Food price", with: @unit.food_price
    fill_in "Health", with: @unit.health
    fill_in "Metal price", with: @unit.metal_price
    fill_in "Name", with: @unit.name
    fill_in "Number", with: @unit.number
    fill_in "Planet", with: @unit.planet_id
    fill_in "Thorium price", with: @unit.thorium_price
    fill_in "Time to build", with: @unit.time_to_build
    click_on "Create Unit"

    assert_text "Unit was successfully created"
    click_on "Back"
  end

  test "updating a Unit" do
    visit units_url
    click_on "Edit", match: :first

    fill_in "Attack", with: @unit.attack
    fill_in "Capacity", with: @unit.capacity
    fill_in "Defense", with: @unit.defense
    fill_in "Food price", with: @unit.food_price
    fill_in "Health", with: @unit.health
    fill_in "Metal price", with: @unit.metal_price
    fill_in "Name", with: @unit.name
    fill_in "Number", with: @unit.number
    fill_in "Planet", with: @unit.planet_id
    fill_in "Thorium price", with: @unit.thorium_price
    fill_in "Time to build", with: @unit.time_to_build
    click_on "Update Unit"

    assert_text "Unit was successfully updated"
    click_on "Back"
  end

  test "destroying a Unit" do
    visit units_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Unit was successfully destroyed"
  end
end
