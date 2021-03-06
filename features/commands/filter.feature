Feature: filter

  In order to see relevant information
  As a command line junkie
  I want to filter the cards that are displayed

  Scenario: filter cards
    When I run `cardigan` interactively
    And I create the following cards:
     | name                         | release |
     | another interesting card     | margay  |
     | a seriously interesting card | ocelot  |
    And I type "filter card['release'] == 'ocelot'"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     --------------------------------------
    | index | name                         |
     --------------------------------------
    | 1     | a seriously interesting card |
     --------------------------------------
    """

  Scenario: filter cards by owner
    When I run `cardigan` interactively
    And I type "touch another interesting card"
    And I type "touch a seriously interesting card"
    And I type "claim 2"
    And I type "filter card['owner'] == me"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     ----------------------------------
    | index | name                     |
     ----------------------------------
    | 1     | another interesting card |
     ----------------------------------
    """