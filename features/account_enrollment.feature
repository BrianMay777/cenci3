@http://www.pivotaltracker.com/story/show/19509981 @account @enroll @i1
Feature: Account Enrollment - Its me Juan...I bought a kit yo, and I wanna get it started up
  Scenario: I bought a kit yo, and I wanna get it started up
    Given I bought a kit with the pin 1111111111
      And I go to new enrollment page
    When I enter my pin
      And I push "Enroll Me!"
    Then I will see a new form asking about me
    When I tell the form about me:
      | ID Number | 559237193 |
      | ID Type | SSN |
      | Name | Juan Diaz |
      | Address | 311 Matrix Lane |
      | Phone | 4155551212 |
      And I swear that I read the terms and agree, ha
      And I push "Join the team!"
    Then I will be on some dashboard thingy page
      And I will see something demanding I check my email
      And an email should be sent to me
      And an email should be sent to the admins
      And I will be waiting on approval, hope it's quick
