Feature: Schedule Feature
  In order to manage schedules
  I
  want to show a decent schedule view
  
  Scenario: Schedule view
    Given a user is logged in as markEmark
      And user creates game game1
    When I go to the home page
    Then I should see "Your Schedule"
      And I should see "Game time"
