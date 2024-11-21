Feature: User Answers
  As a user
  I want to enter my blood pressure
  So that I can see what my blood pressure status is

  Scenario: Successful blood pressure calculation
    Given I am on the calculator page
    When I fill in the blood pressure form with valid details
    And I click the "Calculate" button
    Then I should see "Ideal blood pressure"