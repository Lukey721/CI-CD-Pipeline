# frozen_string_literal: true

Given('I am on the calculator page') do
  visit root_path
end

# ideal blood pressure BDD test
When('I fill in the blood pressure form with valid details') do
  fill_in 'systolic', with: '90'
  fill_in 'diastolic', with: '60'
end

# Invalid BDD test
When('I fill in the blood pressure form with invalid details') do
  fill_in 'systolic', with: '2000' # Invalid input
  fill_in 'diastolic', with: '3'
end

# pre-high blood pressure BDD test
When('I fill in the blood pressure form with valid details to calculate pre-high blood pressure') do
  fill_in 'systolic', with: '130'
  fill_in 'diastolic', with: '85'
end

# high blood pressure BDD test
When('I fill in the blood pressure form with valid details to calculate high blood pressure') do
  fill_in 'systolic', with: '141'
  fill_in 'diastolic', with: '91'
end

# low blood pressure BDD test
When('I fill in the blood pressure form with valid details to calculate low blood pressure') do
  fill_in 'systolic', with: '80'
  fill_in 'diastolic', with: '60'
end

When('I click the {string} button') do |button|
  click_button button
end

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end
