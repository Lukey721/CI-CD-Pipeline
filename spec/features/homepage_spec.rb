require 'rails_helper'

RSpec.feature "Homepage", type: :feature do
  scenario "User visits the homepage" do
    #navigate to root page
    visit "/"
    #verify content on title of page to verify that it is home page of calculator
    expect(page.title).to eq("BloodPressureCalculator")
  end
end