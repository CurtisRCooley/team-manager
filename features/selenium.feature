Feature: Selenium tests

Scenario: Front page
  Given I start on home page
  Then title should be Rec Team Captain
    And close browser
