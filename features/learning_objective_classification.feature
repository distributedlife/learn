Feature: Learning Objective disciplines
  As a tester
  I want learning objectives classified
  So that I can find learning objectives that interest me more easily

  Scenario: learning objective has a discipline
    Given the learning objective "understands how change impacts automation tests" in the "automation" discipline
    When I go to the learning objectives page
    Then I should see "AUTOMATION"

  Scenario: learning objective type is concept
    Given the "concept" "understands how change impacts automation tests" in the "automation" discipline
    When I go to the learning objectives page
    Then I should see "CONCEPT"