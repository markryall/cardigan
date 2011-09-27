Feature: claim

  In order to indicate to others I am allocated to a card
  As a command line junkie
  I want to claim cards

  Scenario: claim cards
    When I run `cardigan touch a very interesting card`
    And I run `cardigan claim 1`
    And I run `cardigan columns name owner`
    And I run `cardigan ls`
    Then the exit status should be 0
    And the stdout should contain:
    """
     ---------------------------------------------------------------------
    | index | name                    | owner                             |
     ---------------------------------------------------------------------
    | 1     | a very interesting card | "Ms Crazy Person" <you@there.com> |
     ---------------------------------------------------------------------
    """