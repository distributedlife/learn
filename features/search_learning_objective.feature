Feature: Learning Objectives
    As a tester
    I want to search learning objectives
    So that I can find ones that are relevant to me more easily


Scenario: search miss
    Given the learning objective "understands how change impacts automation tests" in the "automation" discipline
    And I go to the search learning objectives page
    When I search for "banana"
    Then I should see "No learning objectives found"


Scenario: search hit
    Given the learning objective "understands how change impacts automation tests" in the "automation" discipline
    And the learning objective "understands deductive reasoning and how it relates to software testing" in the "fundamentals" discipline
    And I go to the search learning objectives page
    When I search for "understands"
    Then each learning objective is displayed on the page alphabetically
    And I should not see "No learning objectives found"


Scenario: show result count multiple
    Given 5 learning objectives containing "banana"
    And I am on the search learning objectives page
    When I search for "banana"
    Then I should see "5 results"


Scenario: no result count when no results return
    Given 5 learning objectives containing "banana"
    And I am on the search learning objectives page
    When I search for "awesomesauce"
    Then I should not see "0 results"

Scenario: search text is visible in search box after search 
    Given 5 learning objectives containing "banana"
    And I am on the search learning objectives page
    When I search for "banana"
    Then the "q" field should contain "banana"