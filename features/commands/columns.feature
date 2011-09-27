Feature: columns

  In order to see relevant information
  As a command line junkie
  I want to control the attributes that are displayed

  Scenario: claim cards
    When I run `cardigan` interactively
    And I type "touch another interesting card"
    And I type "set release 1"
    And I type "ocelot"
    And I type "set iteration 1"
    And I type "3"
    And I type "columns name release"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
     --------------------------------------------
    | index | name                     | release |
     --------------------------------------------
    | 1     | another interesting card | ocelot  |
     --------------------------------------------
    """