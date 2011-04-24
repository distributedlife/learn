Feature: Add learning objective
  As a tester
  I want to add learning objectives
  so that other testers can learn from what I know

  Background:
    Given I am on the propose learning objective page

  @javascript
  Scenario: add new learning objective
    When I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | user interaction | concept  |
    Then I should see "This is a new learning ob... is a new concept in the user interaction discipline"
    And the form should be reset
    And I should see "Click here to undo."

  @javascript
  Scenario: undo pending learning objective
    Given I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    When I follow "Click here to undo."
    Then I should see "The learning objective has been removed."

  @javascript
  Scenario: cannot undo an approved learning objective
    Given I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    And all learning objectives are automagically approved
    When I follow "Click here to undo."
    Then I should see "Learning objective cannot be deleted as it has been approved."

  @javascript
  Scenario: cannot create a learning objective that already exists
    Given I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    When I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    Then I should see "that has not been taken"
    Then I should not see "This is a new learning ob... is a new concept in the user interaction discipline"

  @javascript
  Scenario: can create a learning objective that exists in another discipline
    Given I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    When I create a learning objective with:
      | brief                            | discipline       | category |
      | This is a new learning objective | user interaction | concept  |
    Then I should see "This is a new learning ob... is a new concept in the automation discipline"
    Then I should see "This is a new learning ob... is a new concept in the user interaction discipline"

  @javascript
  Scenario: cannot create a learning objective without a brief
    When I create a learning objective with:
      | brief | discipline | category |
      |       |            |          |
    Then I should see "that can't be blank"

  @javascript
  Scenario: cannot create a learning objective where the brief is more than 500 characters
    When I create a learning objective with:
      | brief                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | category   | discipline |
      | 1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | automation | concept    |
    Then I should see "that has to be shorter"

  @javascript
  Scenario: undone learning objectives do not show up in the results
    Given I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    And I follow "Click here to undo."
    When I go to the search learning objectives page
    And pending learning objectives are shown
    And I follow "automation"
    And I follow "concept"
    And I should not see "This is a new learning ob... is a new concept in the automation discipline"
    And I should see "No learning objectives found."

  @javascript @user-journey
  Scenario: newly created learning objectives are always pending
    Given I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    When I go to the search learning objectives page
    And pending learning objectives are shown
    And I follow "automation"
    And I follow "concept"
    And I should see "This is a new learning objective"
    And I should see "This learning objective is not yet approved."

  @javascript @user-journey
  Scenario: multiple created learning objectives all exist on page
    When I create a learning objective with:
      | brief                            | discipline | category |
      | This is a new learning objective | automation | concept  |
    And I create a learning objective with:
      | brief                               | discipline       | category  |
      | This is a second learning objective | user interaction | technique |
    And I create a learning objective with:
      | brief                              | discipline   | category |
      | This is a third learning objective | fundamentals | lens     |
    And I should see "This is a new learning ob... is a new concept in the automation discipline"
    And I should see "This is a second learning... is a new technique in the user interaction discipline"
    And I should see "This is a third learning ... is a new lens in the fundamentals discipline"
