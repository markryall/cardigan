Feature: rm

  In order to manage my ideas
  As a command line junkie
  I want to be able to remove cards that are no longer required

  Scenario: remove a card
    When I run `cardigan` interactively
    And I create the following cards:
     | name   |
     | card 1 |
     | card 2 |
     | card 3 |
     | card 4 |
    And I type "rm 2 3"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
    ----------------
    | index | name   |
     ----------------
    | 1     | card 1 |
    | 2     | card 4 |
     ----------------
    """