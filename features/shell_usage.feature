Feature: cardigan shell usage

  In order to manage my ideas
  As a command line junkie
  I want to use the cardigan commands in an interactive shell

  Scenario: empty card repository
    When I run `cardigan` interactively
    And I type "touch today is the first day of the rest of your life"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     ---------------------------------------------------------
    | index | name                                            |
     ---------------------------------------------------------
    | 1     | today is the first day of the rest of your life |
     ---------------------------------------------------------
    """