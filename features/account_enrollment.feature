@http://www.pivotaltracker.com/story/show/19509981 @account @enroll @i1 @javascript
Feature: Account Enrollment - Its me Juan...I bought a kit yo, and I wanna get it started up
  I am Juan and I bought a $50 kit from Joel
  I want to enroll my kit to activate my account
  So I can enroll more folks

  Scenario: I bought a kit yo, and I wanna get it started up
    Given I bought a kit with the pin 1111111111
      And I go to new enrollment page
    When I enter my pin
      And I push "Enroll Me!"
    Then I will see a new form asking about me
    When I tell the form about me:
      | Id number | Id type | Name      | Address                            | Email          | Phone      | Password | Password confirm |
      | 559237193 | SSN     | Juan Diaz | 311 Matrix Way Lafayette, CA 94549 | juan@gmail.com | 4155551212 | 12345678 | 12345678         |
      And I swear that I read the terms and agree, ha
      And I push "Join the team!"
    Then my account should be pending
      And my pin should be assigned to me
      And my username should be my pin
      And I will be on some dashboard thingy page
      And I will see something demanding I check my email
      And an email should be sent to me
      And an email should be sent to the admins
      And I will be waiting on approval, hope it's quick
