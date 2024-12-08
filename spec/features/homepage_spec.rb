require 'rails_helper'

RSpec.feature "Homepage", type: :feature do
  scenario "User visits the homepage" do
    # navigate to root page
    visit "/"
    # verify content on title of page to verify that it is home page of calculator
    expect(page.title).to eq("BloodPressureCalculator")
  end
end

RSpec.feature "Blood Pressure Calculator Page", type: :feature do
  scenario "Verify all elements have rendered correctly" do
    visit "/"

    # Verify labels
    expect(page).to have_content("Systolic (top number)")
    expect(page).to have_content("Diastolic (bottom number)")

    # Verify fields
    expect(page).to have_field("systolic", type: "number")
    expect(page).to have_field("diastolic", type: "number")

    # Verify submit button
    expect(page).to have_button("Calculate")

    # Verify input is possible and check min and max values
    systolic_field = find_field("systolic")
    expect(systolic_field[:min]).to eq("70")
    expect(systolic_field[:max]).to eq("190")
    #check that input is required
    expect(systolic_field[:required]).to eq("required")

    diastolic_field = find_field("diastolic")
    expect(diastolic_field[:min]).to eq("40")
    expect(diastolic_field[:max]).to eq("100")
    # check that input is required
    expect(diastolic_field[:required]).to eq("required")

    # Verify header is present "Your Blood Pressure Result:"
    expect(page).to have_selector('h2', text: "Your Blood Pressure Result:")
  end
 

  scenario "Verify result is rendered with correct css class" do
    visit "/"

    # Fill in inputs
    fill_in "systolic", with: "120"
    fill_in "diastolic", with: "80"

    # Submit the form
    click_button "Calculate"

    # Locate the result element (
    result_element = find(".pre-high-blood-pressure") # css class
  end

  scenario "Verify result is rendered with correct css class - Low Blood Pressure" do
    visit "/"

    # Fill in inputs
    fill_in "systolic", with: "100"
    fill_in "diastolic", with: "40"

    # Submit the form
    click_button "Calculate"

    # Locate the result element (
    result_element = find(".low-blood-pressure") # css class
  end

  scenario "Verify result is rendered with correct css class - High Blood Pressure" do
    visit "/"

    # Fill in inputs
    fill_in "systolic", with: "190"
    fill_in "diastolic", with: "100"

    # Submit the form
    click_button "Calculate"

    # Locate the result element (
    result_element = find(".high-blood-pressure") # css class
  end

  scenario "Verify result is rendered with correct css class - ideal Blood Pressure" do
    visit "/"

    # Fill in inputs
    fill_in "systolic", with: "119"
    fill_in "diastolic", with: "79"

    # Submit the form
    click_button "Calculate"

    # Locate the result element (
    result_element = find(".ideal-blood-pressure") # css class
  end

  scenario "Verify result is rendered with correct css class - Pre-High Blood Pressure" do
    visit "/"

    # Fill in inputs
    fill_in "systolic", with: "130"
    fill_in "diastolic", with: "80"

    # Submit the form
    click_button "Calculate"

    # Locate the result element (
    result_element = find(".pre-high-blood-pressure") # css class
  end

  scenario "Verify error is rendered with correct css class" do
    visit "/"

    # Fill in inputs
    fill_in "systolic", with: "200"
    fill_in "diastolic", with: "500"

    # Submit the form
    click_button "Calculate"

    # Locate the result element (
    result_element = find(".error-message") # css class
  end
end
