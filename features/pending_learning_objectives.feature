Feature: Learning Objectives
    As a tester
    I want to be able filter pending learning objectives
    So that I can see what learning objectives are not yet approved


Scenario: pending learning objectives are not shown by default
    Given a pending learning objective
    When I go to the learning objectives page
    Then I should see "No learning objectives found"
    And I should see the link "show pending"

Scenario: pending learning objectives are shown when selected
    Given the following pending learning objective "this learning objective is pending"
    And I am on the learning objectives page
    When I follow "show pending"
    Then I should see "this learning objective is pending"
    And I should see the link "hide pending"
    And I should see "This learning objective is not yet approved"
    And I should see the link "Hide pending learning objectives?"

Scenario: pending learning objectives are hidden when deselected
    Given the following pending learning objective "this learning objective is pending"
    And I am on the learning objectives page
    And pending learning objectives are shown
    When I follow "hide pending"
    Then I should see "No learning objectives found"
    And I should see the link "show pending"

Scenario: Hide pending learning objectives does what it says
    Given the following pending learning objective "this learning objective is pending"
    And I am on the learning objectives page
    And pending learning objectives are shown
    When I follow "Hide pending learning objectives?"
    Then I should see "No learning objectives found"

Scenario: approve pending learning objective
    Given the following pending learning objective "this learning objective is pending"
    And I am on the learning objectives page
    And pending learning objectives are shown
    When I press "Approve this learning objective?"
    Then I should not see "Hide pending learning objectives?"

#Scenario: approve one of multiple pending learning objectives
#    Given the following pending learning objective "this learning objective is pending"
#    Given the following pending learning objective "this learning objective is also pending"
#    And I am on the learning objectives page
#    And pending learning objectives are shown
#    When I follow "Approve learning objective?" for "this learning objective is pending"
#    Then I should not see "Hide pending learning objectives?" on "this learning objective is pending"
