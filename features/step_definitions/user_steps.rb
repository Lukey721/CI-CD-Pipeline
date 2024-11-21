Given('I am on the calculator page') do
  visit root_path
end

When('I fill in the blood pressure form with valid details') do
  fill_in 'systolic', with: '120'
  fill_in 'diastolic', with: '80'
end

When('I fill in the blood pressure form with invalid details') do
  fill_in 'systolic', with: '2000'  # Invalid input
  fill_in 'diastolic', with: '3'
end

When('I click the {string} button') do |button|
  click_button button
end

Then('I should see {string}') do |message|
  expect(page).to have_content("Ideal blood pressure")
end