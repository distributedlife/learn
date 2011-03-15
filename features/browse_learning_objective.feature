Feature: Learning Objectives
    As a tester
    I want to browse learning objectives
    So that I can see what is to be learnt in the field of testing


Scenario: no learning objecties found
    Given no learning objectives
    When I go to the learning objectives page
    Then I should see "No learning objectives found"


Scenario: multiple learning objectives
    Given the learning objective "understands how change impacts automation tests"
    And the learning objective "understands deductive reasoning and how it relates to software testing"
    When I go to the learning objectives page
    Then each learning objective is displayed on the page alphabetically
    And I should not see "No learning objectives found"