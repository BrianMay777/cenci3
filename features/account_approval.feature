@http://www.pivotaltracker.com/story/show/19570171 @account @i1 @approval @enroll @boss @javascript
Feature: Account Approval - I'm a boss (Agent), but I like you Juan, so your on the team
  I am Joel an Agent of Cenciyo
  And I sold a $50 kit to Juan a 1st Generation Account
  He enrolled with his kit and is pending approval patiently
  I want to approve his account
  So he can login and enroll more folks

  Scenario: Account Approval - I'm a boss, but I like you Juan, so your on the team
    Given I am an Agent named "Joel Thomas" and I am logged in
      And someone named Juan I slung a kit to enrolled
      And I go to my dashboard
    Then I should see Juan in my list of people waiting for approval
    When I click Approve next to Juan
    Then I should be on my dashboard
      And I should see Juan in my list of approved accounts
      And an email should be sent to Juan
