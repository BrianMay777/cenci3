@http://www.pivotaltracker.com/story/show/19510129 @account @downline @agent @i1 @enroll @javascript
Feature: Account registers downline pin
  Scenario: Its Juan again, I want to register a pin I sold to my buddy
    Given I am an enrolled approved account named "Juan"
      And I am logged in and on my dashboard
    When I enter my buddies pin into the register form
      And I click register
    Then I should be told that my buddies pin has been registered
      And my I should see my buddies pin in my list of registered pins
