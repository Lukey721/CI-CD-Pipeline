Feature: Blood Pressure Calculator
  As a user
  I want to enter my blood pressure
  So that I can see what my blood pressure status is

  Scenario: Successful Ideal blood pressure calculation
    Given I am on the calculator page
    When I fill in the blood pressure form with valid details
    And I click the "Calculate" button
    Then I should see "Ideal blood pressure"

  Scenario: Invalid blood pressure input
    Given I am on the calculator page
    When I fill in the blood pressure form with invalid details
    And I click the "Calculate" button
    Then I should see "Please review the measurements you have entered"