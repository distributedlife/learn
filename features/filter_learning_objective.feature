Feature: Learning Objective disciplines
  As a tester
  I want to filter learning objectives
  So that I can find learning objectives that relate to me more easily

  Scenario: start with can add all disciplines and all categories
    Given one learning objective in all permutations
    And I go to the learning objectives page
    When I follow "automation"
    And I follow "behaviour & functionality"
    And I follow "domain knowledge"
    And I follow "fundamentals"
    And I follow "infrastructure & integration"
    And I follow "performance"
    And I follow "preparation & planning"
    And I follow "security"
    And I follow "user interaction"
    And I follow "artefact"
    And I follow "concept"
    And I follow "lens"
    And I follow "responsibility"
    And I follow "technique"
    Then I should see "No learning objectives found"

  Scenario: can add and remove a discipline filter
    Given the learning objective "understands how change impacts automation tests" in the "automation" discipline
    And the learning objective "is a second learning objective" in the "user interaction" discipline
    And I am on the learning objectives page
    When I follow "automation"
    Then I should see "understands how change impacts automation tests"
    And I should not see "is a second learning objective"

  Scenario: can add and remove a category filter
    Given the "concept" "understands how change impacts automation tests" in the "automation" discipline
    And the "responsibility" "is a second learning objective" in the "user interaction" discipline
    And I am on the learning objectives page
    When I follow "responsibility"
    Then I should see "is a second learning objective"
    And I should not see "understands how change impacts automation tests"