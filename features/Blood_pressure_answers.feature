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

  Scenario: Successful Pre-high blood pressure calculation
    Given I am on the calculator page
    When I fill in the blood pressure form with valid details to calculate pre-high blood pressure
    And I click the "Calculate" button
    Then I should see "Pre-high blood pressure"

  Scenario: Successful high blood pressure calculation
    Given I am on the calculator page
    When I fill in the blood pressure form with valid details to calculate high blood pressure
    And I click the "Calculate" button
    Then I should see "High blood pressure"

  Scenario: Successful low blood pressure calculation
    Given I am on the calculator page
    When I fill in the blood pressure form with valid details to calculate low blood pressure
    And I click the "Calculate" button
    Then I should see "Low blood pressure"