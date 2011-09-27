Feature: total

  In order to see relevant information
  As a command line junkie
  I want to calculate the total of a numeric attribute of cards

  Scenario: incorrect usage of total command
    When I run `cardigan` interactively
    And I type "total"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain "missing required numeric total field"

  Scenario: calculate total without any grouping
    When I run `cardigan` interactively
    And I create the following cards:
     | name   | estimate |
     | card 1 | 3        |
     | card 2 | 2        |
    And I type "total estimate"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     ----------
    | estimate |
     ----------
    | 5        |
     ----------
    """

  Scenario: calculate total with some missing values
    When I run `cardigan` interactively
    And I create the following cards:
     | name   | estimate |
     | card 1 | 3        |
     | card 2 | 2        |
     | card 3 |          |
    And I type "total estimate"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     ----------
    | estimate |
     ----------
    | 5        |
     ----------
    """

  Scenario: calculate total without grouping by a field
    When I run `cardigan` interactively
    And I create the following cards:
     | name   | estimate | release |
     | card 1 | 3        | ocelot  |
     | card 2 | 2        | margay  |
     | card 3 | 5        | margay  |
    And I type "total estimate release"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     --------------------
    | release | estimate |
     --------------------
    | margay  | 7        |
    | ocelot  | 3        |
    |         | 10       |
     --------------------
    """