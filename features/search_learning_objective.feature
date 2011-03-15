Feature: Learning Objectives
    As a tester
    I want to search learning objectives
    So that I can find ones that are relevant to me more easily


Scenario: search miss
    Given the learning objective "understands how change impacts automation tests"
    And I go to the learning objectives page
    When I search for "banana"
    Then I should see "No learning objectives found"


Scenario: search hit
    Given the learning objective "understands how change impacts automation tests"
    And the learning objective "understands deductive reasoning and how it relates to software testing"
    And I go to the learning objectives page
    When I search for "understands"
    Then each learning objective is displayed on the page alphabetically
    And I should not see "No learning objectives found"