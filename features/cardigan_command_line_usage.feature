Feature: cardigan command line usage

  In order to manage my ideas
  As a command line junkie
  I want to use the cardigan commands without entering a shell

  Scenario: empty card repository
    When I run `cardigan ls`
    Then the exit status should be 0
    And the stdout should contain:
    """
    There are no cards to display
    """

  Scenario: single card repository
    When I run `cardigan touch do some amazing stuff with my life`
    And I run `cardigan ls`
    Then the exit status should be 0
    And the stdout should contain:
    """
     --------------------------------------------
    | index | name                               |
     --------------------------------------------
    | 1     | do some amazing stuff with my life |
     --------------------------------------------
    """