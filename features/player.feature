Feature: Player Feature
  In order to manage players
  I
  want to show a decent player view
  
  Scenario: Players view
    Given a user is logged in as markEmark
    And schedule the_schedule belongs to user markEmark
    And player me@here.org belongs to schedule the_schedule
    And I go to the home page
    And I follow "the_schedule"
    When I follow "Players" 
    Then I should see "me@here.org"

  Scenario: Player view
    Given a user is logged in as markEmark
    And schedule the_schedule belongs to user markEmark
    And player me@here.org belongs to schedule the_schedule
    And I go to the home page
    And I follow "the_schedule"
    And I follow "Players" 
    When I follow "Show"
    Then I should see "Email: me@here.org"
      And I should see "Reserve:"

  Scenario: Player edit
    Given a user is logged in as markEmark
    And schedule the_schedule belongs to user markEmark
    And player me@here.org belongs to schedule the_schedule
    And I go to the home page
    And I follow "the_schedule"
    And I follow "Players" 
    When I follow "Edit"
    Then I should see "Player Management"
      And the "email" field should contain "me@here.org"
      And the "reserve" checkbox should not be checked

  Scenario: Player edit
    Given a user is logged in as markEmark
	    And schedule the_schedule belongs to user markEmark
	    And player me@here.org belongs to schedule the_schedule
	    And I go to the home page
	    And I follow "the_schedule"
	    And I follow "Players" 
	    And I follow "Edit"
            And I check "Reserve"
            And I press "Update"
    Then I should see "Email: me@here.org"
            And I should see "Reserve: Yes"
