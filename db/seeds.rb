# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
Definitions.create(:topic => 'discipline', :name => 'automation', :description => 'The automation discipline covers everything that a tester does with regards to automated exploratory testing, automated regression testing and the use and creation of tools that assist in manual testing.')
Definitions.create(:topic => 'discipline', :name => 'behaviour & functionality', :description => 'b')
Definitions.create(:topic => 'discipline', :name => 'domain knowledge', :description => 'c')
Definitions.create(:topic => 'discipline', :name => 'fundamentals', :description => 'd')
Definitions.create(:topic => 'discipline', :name => 'infrastructure & integration', :description => 'e')
Definitions.create(:topic => 'discipline', :name => 'performance', :description => 'f')
Definitions.create(:topic => 'discipline', :name => 'preparation & planning', :description => 'g')
Definitions.create(:topic => 'discipline', :name => 'security', :description => 'h')
Definitions.create(:topic => 'discipline', :name => 'user interaction', :description => 'i')

Definitions.create(:topic => 'category', :name => 'concept', :description => 'j')
Definitions.create(:topic => 'category', :name => 'responsibility', :description => 'k')
Definitions.create(:topic => 'category', :name => 'technique', :description => 'l')
Definitions.create(:topic => 'category', :name => 'artefact', :description => 'm')
Definitions.create(:topic => 'category', :name => 'lens', :description => 'n')

current_discipline = 'behaviour & functionality'
current_category = 'concept'
LearningObjective.create(:brief => "Understands equivalence partitioning and how it can be used to identify test cases", :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => "Use boundary analysis to identify states in complex business objects that may impact expectations", :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Use boundary analysis to identify states in complex business objects that may impact expectations', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse the documented requirements, user expectations use cases, user stories, marketing material and help and training material to identify test cases', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can test system behaviour by combining functionality implemented within the system', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Creation of end to end behavioural testing scenarios that exercise multiple systems within the organisation.', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
current_category = 'artefact'
current_category = 'lens'
LearningObjective.create(:brief => 'Functionality – what the functions of the system are and testing to ensure the system meets the specified expectations; this is done in both a positive and negative sense', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Behavioural – system behaviour is a feature that the system supports, potentially via functional integration or potentially through multiple discrete, isolated functions. Behavioural testing seeks to ensure that the expected behaviour is supported by the system and that behaviour is consistent across the system.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Compliance – testing the system to ensure that it meets any required standards for functionality or behaviour.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Regression – the identification of test cases that should be run after subsequent system changes to ensure the system has not regressed', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Data Integrity – inspection of system data after each function test is executed to identify incorrect storage of data', :discipline => current_discipline, :category => current_category)

current_discipline = 'planning & preparation'
current_category = 'concept'
LearningObjective.create(:brief => 'Is aware of and understands each of the other disciplines so that the test plan can include accurate resource provisions and estimates', :discipline => current_discipline, :category => current_category)

LearningObjective.create(:brief => 'Understands different estimation models, how they relate to testing within the organisation', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understand the various models that exist for software testing and which is one is more appropriate for the organisation', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the different test environment configurations', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Is aware of and understands each of the other disciplines so that the test strategy can include accurate resource provisions and estimates', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Provide input into processes for test design peer reviews', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Provide input into processes for test case specification peer reviews', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Provide input into processes for test execution peer reviews', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Provide input into the defect workflow process', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce a test plan without relying on a template', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Provide input into the project initiation phase by supplying a high level testing strategy, test estimates and test resource needs.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce the test summary report at the completion of a testing project.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Allocate effort to members of the test team relative to their discipline', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Negotiate sponsor signoff with the project owners', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Discuss, mentor or train current employees on testing fundamentals', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Communicate effectively with the project manager on project progress', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Report to test management the performance of the project team', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce metrics to test management regarding performance of the test team and the project', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Effectively communicate with the development lead to negotiate test engagement', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Effectively communicate with the development lead to negotiate defect resolution processes', :discipline => current_discipline, :category => current_category)

LearningObjective.create(:brief => 'Can estimate effectively for future testing effort', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define processes for test design peer reviews', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define processes for test case specification peer reviews', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define processes for test execution peer reviews', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define the defect workflow process', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Plan the test environment configuration is best given the organisational resources', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define the structure for teams working within the testing area', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Review current skill sets and allocate training or acquire new resources to cover current skill shortages', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define the role testing plays in the organisation', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Recruitment and retention of skilled testing personnel based on current and future testing needs', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Planning, deploying, and managing the testing effort for any given engagement / release.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce the short term test strategy', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce the test future direction plan', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Report to upper management the performance of the testing team', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
current_category = 'artefact'
LearningObjective.create(:brief => 'Test Plan – outlines the testing effort to be undertaken on a given project. Includes scope, estimations, risks and issues, environment configuration, resourcing and required disciplines.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Test Summary Report – details the testing that was undertaken on the project and the state of the testing', :discipline => current_discipline, :category => current_category)

LearningObjective.create(:brief => 'Short Term Test Strategy – defines the testing resources, training, approaches and utilisation over the coming 12-24 month period', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Test Future Direction Plan – defines the testing resource, training and approaches to meet the expected organisational testing needs based on the CTO Future Direction', :discipline => current_discipline, :category => current_category)

current_category = 'lens'


current_discipline = 'user interaction'
current_category = 'concept'
LearningObjective.create(:brief => 'Understands the difference between user testing and user feedback', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Analyse the any potential requirements to develop workflows and identify potential user interaction issues', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse user interface wireframes and identify potential user interaction issues.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Read and review the training & help to ensure correct usage of business language; that it has correct spelling, grammar and tone; has correct content; is easy to learn and provides task oriented concise manuals.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can organise and run User Acceptance Testing sessions', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Organise and run User testing sessions and understands the implications of user demographic on such sessions', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce the User Acceptance Testing report after the UAT sessions have completed and all feedback received.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse product marketing and training material to develop test scenarios that exercise user expectations', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse the requirement specifications to develop user interaction test cases', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse user interface wireframe and develop user interaction test cases', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Design tests that ensure the cultural background, psychological mindset and physical attributes of a user do not impact the user experience', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Design tests that ensure all potential invocation mechanisms are catered for and support full user interaction with the system', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Is able to debate user interaction issues calmly and intelligently.', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
LearningObjective.create(:brief => 'Can apply the A/B testing technique in order to quantify an aspect of a design.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can apply the ladder interview technique to identify user motivations.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can apply one of several usability inspection techniques (cognitive walkthrough, heuristic evaluation, pluralistic walkthrough) to identify design issues.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can apply the ‘think aloud’ technique for identifying user interaction issues', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can apply the hallway testing technique for identifying user interaction issues', :discipline => current_discipline, :category => current_category)

current_category = 'artefact'
LearningObjective.create(:brief => 'User Accepting Testing Report – This report details the outcomes of the UAT session and details the input from the users. The report can contain an outline of what will be fixed in the current release and will detail which concerns will not be resolved. This report is relayed to the owners for signoff.', :discipline => current_discipline, :category => current_category)

current_category = 'lens'
LearningObjective.create(:brief => 'Accessibility – testing the user interaction so that it meets accessibility requirements for the intended users, organisation, country or standards committee. WCAG2.0 is the current W3 standard for web content accessibility.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Consistency – the system should be consistent in its behaviour and interaction mechanisms. Consistency testing should also ensure that common UI components are used in ways that they user would expect.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Internationalisation & Localisation – internationalisation testing covers the adaption of the system for potential use. Testing should focus on the mechanisms for internationalisation rather than the outcomes. Localisation testing covers the adaption of a software system for particular locale. It covers language and dialect translation, use of symbols, aesthetics, sort order, subtitling, cultural values and writing conventions.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Structure – The structure of the user interface should be consistent and relevant to the functional purpose. It is making sure that the layout of the user interface has logical groupings of information, it contains sufficient information without being busy and workflows between screens make sense.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Training & Help – the training and help testing focuses on ensuring that each UI component provides contextual help where necessary.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Trustworthiness – focuses on ensuring that the system is forgiving of user errors and respond quickly to user input. A trustworthy system should allow the user to interact with it without fear of penalty.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Usability – testing the usability of a system covers concepts such as efficiency, memorability, learnability, satisfaction and tolerance. An efficient system should be easy to use whilst satisfaction encompasses the usefulness of the system.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Visibility – how well the system allows the user to construct a mental model and predict the effect of their actions. The user interaction tester should be able to identify when system information will assist users in making the best decision. Clear & simple navigation, good feedback, predicable behaviour, etc.', :discipline => current_discipline, :category => current_category)


current_discipline = 'domain knowledge'
current_category = 'concept'
LearningObjective.create(:brief => 'Understands the language used by the business', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the business and the role software plays within the business', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Analyse the requirements to develop test scenarios that model how the business is going to use the system', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse the requirements in the context of the business to ensure that the specified requirements are going to meet the needs of the business.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analysis of semantic contracts, both explicit and implicit within the system to identify potential defects', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Discuss the impact and severity of the defect from the perspective of the user.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Documentation of tacit knowledge as it is discovered', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Identify systems that due their impacts on society or life require failure evident capabilities but do not feature them', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
current_category = 'artefact'
current_category = 'lens'

current_discipline = 'automation'
current_category = 'concept'
#common
LearningObjective.create(:brief => 'Has a solid understanding of the concepts of software development and can apply them in development automation test cases or a automation test framework', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands when automation is the ideal approach for behaviour verification and when it should not be used at all', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands how change impacts automation tests', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the value of automation with respect to repeated execution against changing environment states', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understand the difference between identity and anonymous data and the impacts it has on automated data creation and automated test execution', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understanding the difference between data dependant and data independent tests and when to use each one', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference between testing and checking', :discipline => current_discipline, :category => current_category)

  #interface
LearningObjective.create(:brief => 'Understanding the role the component plays in the organisation and the impact that has on testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference between RPC, Message and Message Bus invocation mechanisms and how that impacts testing.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands component configuration based on technologies selected by developers', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the law of leaky abstractions and how that can manifest in implied dependencies in the interface', :discipline => current_discipline, :category => current_category)

  #service
LearningObjective.create(:brief => 'Understands the difference between SOAP, WCF and RESTful services and how they impact service testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands service discovery and how that impacts service integration testing.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference between service orchestration and service choreography and how they impact service integration tests', :discipline => current_discipline, :category => current_category)
#ui
LearningObjective.create(:brief => 'Understands the complexities associated with writing checks for different UI technologies and how that impacts check authoring.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the impacts of change on UI automation checks and how to alleviate these issues.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the purpose of UI automation and that it is not always focused on identifying bugs that exist now', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the additional complexities identity data places on UI automation checks especially when it results in custom workflows', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
#common
LearningObjective.create(:brief => 'Write automation tests that are resilient against change', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Create both state and input data for use within automated tests', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use programming languages associated with the infrastructure to assist in testing.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use programming languages associated with the automation tool.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Debug automation test code during development and fix broken automation scripts.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use the organisation’s automated testing tool set to execute automated tests', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Writing new automation tools', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Evaluation of difference automation tools to identify which one is best for the organisation given specific criterion', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Define processes for automation code reviews', :discipline => current_discipline, :category => current_category)
  #interface
LearningObjective.create(:brief => 'Analyse the component contract to create test scenarios', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse component documentation to create test scenarios', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Identify a change in component contract and update test accordingly', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Automation the configuration of a component for testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Configuring the component tool to work with non-trivial component configurations', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the standards associated with component development (SOAP, WCF standards, etc)', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Communicate effectively with developers to relay potential design or implementation issues', :discipline => current_discipline, :category => current_category)
#ui
LearningObjective.create(:brief => 'Liaise with the other test disciplines to devise appropriate automation scenarios', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Develop automation scripts that are resistant to changes in the content and layout of the user interface', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Work with performance testers to develop automation performance tests that with the user interface', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
#common
LearningObjective.create(:brief => 'Can communicate with other infrastructure components programmatically to assist in testing. E.g. calling a database to verify state data', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands mocks and how they can be used for isolating systems under test.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands stubs and how they can be used for isolating systems under test', :discipline => current_discipline, :category => current_category)
#interface
LearningObjective.create(:brief => 'The analysis of component contracts to identify design issues', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'The analysis of component documentation to identify design issues', :discipline => current_discipline, :category => current_category)
#ui
LearningObjective.create(:brief => 'Is able to identify when to use UI automation to create data and when to use non UI based techniques.', :discipline => current_discipline, :category => current_category)

current_category = 'artefact'
current_category = 'lens'
#interface
LearningObjective.create(:brief => 'Input Validation – testing the component contract with varying forms of invalid data. Considers invalid data in terms of the contract (technical) and invalid data in terms of the business (semantic).', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Functionality – testing the functionality of the component in isolation', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Security – working with the security tester to test the security characteristics of the component from infrastructure and message security to business security implementations.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Compliance – testing the component to ensure it complies with applicable standards.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Exception Reporting – testing the component to ensure that it reports exception information correctly and appropriately.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Auditing – working with the security tester to ensure the component correctly audits requests made to it and that the audit information is secure.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Data Persistence Integrity – ensuring that any information persisted by the component is done in a consistent manner.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Negative Testing – executing a positive test path scenario over an incorrectly configured component to ensure the component gracefully handles the error.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Interoperability – Testing the component so that it can be used with different technologies (Java vs. dotNet, etc)', :discipline => current_discipline, :category => current_category)

current_discipline = 'performance'
current_category = 'concept'
LearningObjective.create(:brief => 'Understanding why performance testing is done', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understanding the observer effect and its impact in your performance test', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understanding controllers and agents and their usage in performance testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understanding protocols and how they are relevant for different types of performance problems and solution architectures.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Has a solid understanding concepts of software development and can apply them in development performance test cases or a performance test framework', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the implications of virtualisation on performance testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understand the difference between clustering and load balancing and the implications each has on performance testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands background noise and implications it has on performance test results', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the implications of different operating systems on performance', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the implications of virtual machines on performance', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands how infrastructure components communicate and can therefore devise test scenario based on this information', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Is aware of the available profiling counters and knows which ones to use to diagnose a particular performance problem.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference between throughput (transactions per interval) and latency (responsiveness) and can identify when performance tests should measure either.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands what a resource bound component is how that impacts performance. Is able to articulate why a resource bound component can be an issue.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands what a CPU bound component is and how that impacts performance. Is able to articulate why a CPU bound component can be an issue.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands what CPU starvation is and how that impacts performance. Is able to articulate why a CPU starved component is an issue for the current architecture.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands what handshake issues are and how they impact performance. Is able to identify handshake issues.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference resources that are available within an environment and how these are used (e.g. threads, handles)', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands how different resource allocation policies can impact or benefit performance.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands how difference caching policies can impact or benefit performance.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the concept of thrashing and can identify it within performance testing results.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference between message size policies and how that can impact on performance.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the horizontal and vertical scaling models, tradeoffs between both and can perform scalability testing on either.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands IP Switching or IP Spoofing and how that impacts on performance tests.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the current and intended growth to be used in load and volume scenarios', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Use the organisation’s performance testing tool set to execute performance tests', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use programming languages associated with the automation tool.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Debug automation test code during development and fix broken performance tests.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Create or identify state and input data needed to satisfy a performance testing scenario and is aware of the implications of data creation during performance testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understand the difference between identity and anonymous data and the impacts it has on automated data creation', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse system architecture design to identify potential bottlenecks', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Read network topologies and devise test scenarios from them', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Create end to end test scenarios that better mimic production usage and understands the difference between isolated and integrated performance tests', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Make recommendations for improving architectural design with respect to performance issues', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Is able to evaluate multiple potential performance testing tools and evaluate them against criterion to determine which tool is best for a given organisation.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce the performance test report at the completion of all performance testing activities for a project', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce the performance test plan using available knowledge of project and current architectural design.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Produce a ‘state of the system’ benchmark document that identifies each infrastructure component and their ‘load’ levels during standard, peak and trough times.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Establish and manage a performance testing environment so that it best replicates production whilst allowing the isolation of new components.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Test the system failure evident capabilities using performance testing techniques.', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
current_category = 'artefact'
LearningObjective.create(:brief => 'Performance Test Plan – The performance test plan details what performance testing is going to be undertaken on a project, where it will occur and who is doing it.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Performance Report – The performance report is produced after all performance testing has been completed. It outlines how the testing went and if there are any pending issues or future performance constraints.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'State of the System Report – The state of the system report should be compiled after each production deployment. It documents each infrastructure component and the amount of ‘load’ that it experiences. The load should be separated into min, peak and average. This is used with performance testing to determine issues that may occur when the system is deployed to production.', :discipline => current_discipline, :category => current_category)

current_category = 'lens'
LearningObjective.create(:brief => 'Performance – the fundamentals of performance tests are to measure two things; throughput and latency. This is the first step where basic timings are recorded without load.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Load – how does the system operate under difference usage scenarios? Load testing looks at three basic tests; the spike test where many users access the system at once; the soak test where there is a high load activity over an extended period of time and the expected usage scenario.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Volume – volume testing is the inverse of load testing; where rather than changing the concurrency of users we alter scope of their effort. A search test may be performed with both one million and ten million records to see how the volume change impacts the performance', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Stress – stress test is done to determine the maximum capacity of the system. Aside from pushing volume and load to their maximum possible levels there are other ways to stress the system: resource restrictions, resource competition and bandwidth throttling.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Reliability – similar to the soak test, the reliability test is performed to determine whether or not the solution meets its uptime requirements given expected usage.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Scalability – here we look at how well the system can scale out. We can do this by throttling server capacity and seeing how easily the system scales horizontally or vertically.', :discipline => current_discipline, :category => current_category)

current_discipline = 'security'
current_category = 'concept'
current_category = 'responsibility'
current_category = 'technique'
current_category = 'artefact'
current_category = 'lens'

current_discipline = 'infrastructure & integration'
current_category = 'concept'
LearningObjective.create(:brief => 'Understands the different integration techniques: Top-down, Bottom-Up and Big Bang and when to apply it', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands what infrastructure is deployed in the environment and how that impacts the system under test', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands what systems are deployed in the environment and how that impacts the system under test', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the concepts of configuration management', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the production administration teams are users of the system and that the developed solution is usable for them.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands difference backup strategies and their uses', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands component configuration based on technologies selected by developers', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Factor the impacts of platforms have on test outcomes during test design and prepare cases that exercise the different browsers, virtual machines and operating system', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Factor the impacts of environments on test outcomes during test design and prepare cases that determine the impact of relevant hardware, peripherals and virtualisation.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse the system architecture in order to determine test scenarios', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Perform administration of infrastructure components for the purposes of test execution and data creation', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Communicates with system administration teams to get their perspective on the system within the environment.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Verify organisational system operations can monitor system behaviour and can respond accordingly to system failure', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
LearningObjective.create(:brief => 'Can apply fuzz testing for the purpose of robustness testing', :discipline => current_discipline, :category => current_category)

current_category = 'artefact'
current_category = 'lens'
LearningObjective.create(:brief => 'Deployment – focuses on the act of deployment whether via user installation or desktop rollout techniques. Deployment testing looks at whether the application can be installed easily with no manual steps, the workflow for installation is correct and that the application works on all supported hardware and software configurations.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Failover – Failover is the capability for infrastructure components to switch over to secondary components in the event of failure. Testing looks at whether the setup failover configuration works correctly by running failover scenarios.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Backup & Recovery – tests the backup and recovery procedures for an application or infrastructure component. Backup & Recovery should investigate all components that can fail and ensure that the system can be restored in the event of failure.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Disaster Recovery – tests the disaster recovery plan. Simulate disasters by disabling infrastructure in a controlled way and then following the plan to ensure that it works.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Integration – tests the integration of system components with respect to a project or change. Includes both project delivered components, existing components, 3rd party components (browser upgrades, security patches, etc) and ‘Off the Shelf’ products', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Instrumentation – Instrumentation is data provided by an application during runtime. This can be used to diagnose or identify developing issues. Instrumentation testing focuses on ensuring the content is correct and written at appropriate times.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Robustness – Looks at how well a system handles invalid or incorrect configuration. Robustness of input is covered in User Interaction or Business & Functionality Testing so we focus exclusively on the interactions between the system and its components or the system and the environment.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Interoperability – focuses on testing system components can be communicated with using different technologies. For example interoperability testing can be done on a service to ensure it can be consumed by both .NET and Java clients.', :discipline => current_discipline, :category => current_category)


current_discipline = 'fundamentals'
current_category = 'concept'
LearningObjective.create(:brief => 'understands exploratory testing and how it can be used as an approach to software testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the role of software testing and is able to explain the who, what, where, how, why and when of software testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the difference between technical and semantic compliance and how that impacts the scope of testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands deductive reasoning and how it relates to software testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands inductive reasoning and how it relates to sotware testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands set theory from mathematic logic and how that relates to software testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands proof theory from mathematyic logic and how that relates to software testing', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Understands the concepts and techniques of program correctness and how that relates to software testing', :discipline => current_discipline, :category => current_category)

current_category = 'responsibility'
LearningObjective.create(:brief => 'Produce test procedures that provide additional information necessary to complete a test case. Test procedures document the how of a test case.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Design tests that are discrete; this means that they only test one thing.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Design tests that consider and cater for all relevant input data combinations', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Design tests that explicitly state the expectations of the tester', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Design tests that can be executed by another competent tester without intervention', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analyse system behaviour to identify state data that will influence the expectations outcome and from this derive test cases that exercise these expectations', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Analysis of test outcomes to identify defects', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'The ability to create both input and state data to satisfy the test case', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'The creation of defect reports that are accurate, reproducible and have an appropriate severity', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Perform test case design reviews to ensure appropriate test coverage has been provided', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Perform test case reviews to ensure test cases are written to the agreed standard', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Perform test execution review to ensure test execution logs are correctly recorded', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Fulfil the obligation of software testing by providing information to stakeholders regarding the quality of the solution', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Communicate effectively by providing metrics to management regarding the testing effort', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Escalate risks before they develop into issues', :discipline => current_discipline, :category => current_category)

current_category = 'technique'
LearningObjective.create(:brief => 'Use hypothesis testing to prove or disprove an assumption', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use positive path testing techniques to derive test cases that prove requirement implementation has been successful', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use negative path testing techniques to derive test cases that exercise the inverse of the specified requirements', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'The ability to risk asses the test suite to identify cases that should be executed first because they present the biggest risk to the organisation if they fail.', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Application of the divide & conquer approach to failed tests to identify the root cause of a defect', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can analyse documented requirement and determine whether they are unambiguous', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Can analyse documented requirement and determine whether they are testable', :discipline => current_discipline, :category => current_category)
LearningObjective.create(:brief => 'Use root cause analysis to identify the root cause of a defect', :discipline => current_discipline, :category => current_category)

current_category = 'artefact'
current_category = 'lens'