Feature: register a new user
As a new user
I want to be able to register
So I can use the system

Scenario: new user registration
  Given a new user curtis.cooley@gmail.com
  When I register
  Then I should get an email
    And the email should contain a validation url
