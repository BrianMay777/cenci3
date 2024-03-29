@http://www.pivotaltracker.com/story/show/19661543 @users @i1 @javascript
Feature: User Sessions - I am some form of user and I need to login and logout
  Scenario: User logs in and gets a session
    Given I am an active user named "Brian"
      And I am on the root page
    When I enter my authentication info
      And click login
    Then I should see a welcome back message

  Scenario: Account logs in and gets a session
    Given I am an active account named "Juan"
      And I am on the root page
    When I enter my authentication info
      And click login
    Then I should see a welcome back message

  Scenario: Agent logs in and gets a session
    Given I am an active agent named "Joel"
      And I am on the root page
    When I enter my authentication info
      And click login
    Then I should see a welcome back message

  Scenario: User logs out and session is deleted
    Given I am an active user named "Brian"
      And I am logged in
      And I am on the root page
    When I click logout
    Then I should see a take it easy message

  Scenario: Unknown users cannot login
    Given I am on the root page
    When I enter my bogus authentication info
      And click login
    Then I should see a firm rejection
