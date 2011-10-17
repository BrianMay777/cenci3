@http://www.pivotaltracker.com/story/show/19750927 @account @downline @enroll @i1 @agent @javascript
Feature: Downline Account Enrollment - Its me Jorge, I bought a kit from Juan and I want to get started up
  I am Jorge
  I bought a kit from Juan, an enrolled Account
  I have my pin and I want to register

  Scenario: Downline Account Enrollment
    Given I bought a kit from Juan with the pin 2222222222
      And I go to the new enrollment page
    When I enter my pin
      And I push "Enroll Me!"
    Then I will see a new form asking about me
    When I tell the form about me:
      | Id number | Id type | Name       | Address                            | Email           | Phone      | Password | Password confirm |
      | 223873124 | SSN     | Jorge Diaz | 311 Matrix Way Lafayette, CA 94549 | jorge@gmail.com | 4155551313 | 12345678 | 12345678         |
      And I swear that I read the terms and agree, ha
      And I push "Join the team!"
    Then my account should be pending
      And my pin should be assigned to me
      And my username should be my pin
      And my parent should be Juan
      And I should be Juans child
      And I will be on some dashboard thingy page
      And I will see something demanding I check my email
      And an email should be sent to me
      And an email should be sent to the admins
