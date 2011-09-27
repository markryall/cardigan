Feature: ls

  In order to manage my ideas
  As a command line junkie
  I want to list my cards

  Scenario: empty card repository
    When I run `cardigan ls`
    Then the exit status should be 0
    And the stdout should contain "There are no cards to display"

  Scenario: a single card is added in shell
    When I run `cardigan` interactively
    And I create the following cards:
     | name   |
     | card 1 |
     | card 2 |
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     ----------------
    | index | name   |
     ----------------
    | 1     | card 1 |
    | 2     | card 2 |
     ----------------
    """