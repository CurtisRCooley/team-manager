Feature: register a new user
As a new user
I want to be able to register
So I can use the system

Scenario: new user registration
  Given a new user curtis.cooley@gmail.com
  When I register
  Then user curtis.cooley@gmail.com should exist
    And registration key should not be nil
