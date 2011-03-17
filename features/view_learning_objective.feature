Feature: Learning Objectives
    As a tester
    I want to browse learning objectives
    So that I can see what is to be learnt in the field of testing


Scenario: no learning objecties found
    Given no learning objectives
    When I go to the learning objectives page
    Then I should see "No learning objectives found"


Scenario: multiple learning objectives, sorted alphabetically by discipline and then alphabetically by brief
    Given the learning objective "understands how change impacts automation tests" in the "automation" discipline
    And the learning objective "understands a row the comes second is placed first" in the "automation" discipline
    And the learning objective "understands deductive reasoning and how it relates to software testing" in the "fundamentals" discipline
    When I go to the learning objectives page
    And I should not see "No learning objectives found"