Feature: unfilter

  In order to see relevant information
  As a command line junkie
  I want to filter the cards that are displayed

  Scenario: remove filter from cards
    When I run `cardigan` interactively
    And I create the following cards:
     | name                         | release |
     | another interesting card     | margay  |
     | a seriously interesting card | ocelot  |
    And I type "filter card['release'] == 'ocelot'"
    And I type "unfilter"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     --------------------------------------
    | index | name                         |
     --------------------------------------
    | 1     | a seriously interesting card |
    | 2     | another interesting card     |
     --------------------------------------
    """