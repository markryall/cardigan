Feature: export

  In order to interoperate with other tracking systems
  As a command line junkie
  I want to export my cards to csv

  Scenario: export cards to csv
    When I run `cardigan` interactively
    And I create the following cards:
     | name   |
     | qwer   |
     | asdf   |
     | zxcv   |
    And I type "export cards"
    And I type "exit"
    Then the exit status should be 0
    And the file "cards.csv" should match /^id,name$/
    And the file "cards.csv" should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12},qwer$/
    And the file "cards.csv" should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12},asdf$/
    And the file "cards.csv" should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12},zxcv$/
