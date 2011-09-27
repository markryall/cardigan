Feature: set

  In order to manage my ideas
  As a command line junkie
  I want to be able to bulk edit attributes of cards

  Scenario: editing an attribute on multiple cards
    When I run `cardigan` interactively
    And I create the following cards:
     | name   |
     | card 1 |
     | card 2 |
     | card 3 |
     | card 4 |
    And I type "set estimate 1 4 "
    And I type "10"
    And I type "columns name estimate"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     ---------------------------
    | index | name   | estimate |
     ---------------------------
    | 1     | card 1 | 10       |
    | 2     | card 2 |          |
    | 3     | card 3 |          |
    | 4     | card 4 | 10       |
     ---------------------------
    """