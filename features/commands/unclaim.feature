Feature: unclaim

  In order to indicate to others I am no longer allocated to a card
  As a command line junkie
  I want to unclaim cards

  Scenario: claim cards
    When I run `cardigan touch a very interesting card`
    And I run `cardigan unclaim 1`
    And I run `cardigan columns name owner`
    And I run `cardigan ls`
    Then the exit status should be 0
    And the stdout should contain:
    """
     -----------------------------------------
    | index | name                    | owner |
     -----------------------------------------
    | 1     | a very interesting card |       |
     -----------------------------------------
    """