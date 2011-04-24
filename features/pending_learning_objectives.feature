Feature: Learning Objectives
    As a tester
    I want to be able filter pending learning objectives
    So that I can see what learning objectives are not yet approved


Scenario: pending learning objectives are not shown by default
    Given a pending learning objective
    When I go to the search learning objectives page
    Then I should see "No learning objectives found"
    And I should see the link "show pending"

Scenario: pending learning objectives are shown when selected
    Given the following pending learning objective "this learning objective is pending"
    And I am on the search learning objectives page
    When I follow "show pending"
    Then I should see "this learning objective is pending"
    And I should see the link "hide pending"
    And I should see "This learning objective is not yet approved"

Scenario: pending learning objectives are hidden when deselected
    Given the following pending learning objective "this learning objective is pending"
    And I am on the search learning objectives page
    And pending learning objectives are shown
    When I follow "hide pending"
    Then I should see "No learning objectives found"
    And I should see the link "show pending"

@javascript
Scenario: approve pending learning objective
    Given the following pending learning objective "this learning objective is pending"
    And I am on the search learning objectives page
    And pending learning objectives are shown
    When I follow "Approve this learning objective?"
    Then I should not see "This learning objective is not yet approved."
    And I should see "Click here to undo."

@javascript
Scenario: undo an approved pending learning objective
    Given the following pending learning objective "this learning objective is pending"
    And I am on the search learning objectives page
    And pending learning objectives are shown
    And I follow "Approve this learning objective?"
    When I follow "Click here to undo."
    Then I should see "This learning objective is not yet approved."

@javascript
Scenario: redo an undone approved pending learning objective
    Given the following pending learning objective "this learning objective is pending"
    And I am on the search learning objectives page
    And pending learning objectives are shown
    And I follow "Approve this learning objective?"
    And I follow "Click here to undo."
    When I follow "Click here to redo."
    Then I should not see "No learning objectives found"