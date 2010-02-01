Feature: Schedule Feature
  In order to manage schedules
  I
  want to show a decent schedule view
  
  Scenario: Schedule view
    Given a user is logged in as markEmark
      And schedule the_schedule belongs to user markEmark
      And game game1 belongs to schedule the_schedule
      And I go to the home page
      And I follow "Your Schedules"
    When I follow "the_schedule"
    Then I should see "Games"
      And I should see "Game time"
