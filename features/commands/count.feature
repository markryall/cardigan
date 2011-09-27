Feature: count

  In order to see relevant information
  As a command line junkie
  I want to count the cards that are displayed

  Scenario: count total cards
    When I run `cardigan` interactively
    And I create the following cards:
     | name   |
     | card 1 |
     | card 2 |
    And I type "count"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     -------
    | count |
     -------
    | 2     |
     -------
    """

  Scenario: count total cards grouped by an attribute
    When I run `cardigan` interactively
    And I create the following cards:
     | name   | release |
     | card 1 | ocelot  |
     | card 2 | ocelot  |
     | card 3 | margay  |
    And I type "count release"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     -----------------
    | release | count |
     -----------------
    | margay  | 1     |
    | ocelot  | 2     |
    |         | 3     |
     -----------------
    """

  Scenario: count total cards grouped by an attribute
    When I run `cardigan` interactively
    And I create the following cards:
     | name   | release |
     | card 1 | ocelot  |
     | card 2 | margay  |
     | card 3 |         |
    And I type "count release"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     -----------------
    | release | count |
     -----------------
    |         | 1     |
    | margay  | 1     |
    | ocelot  | 1     |
    |         | 3     |
     -----------------
    """