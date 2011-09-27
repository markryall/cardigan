Feature: cd

  In order to manage my ideas
  As a command line junkie
  I want to be able to edit individual attributes of a card

  The cd command is named because you are 'changing directory' to edit a card.

  Scenario: export cards to csv
    When I run `cardigan touch a very interesting card`
    And I run `cardigan cd a very interesting card` interactively
    And I type "set estimate"
    And I type "10"
    And I type "ls"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
    estimate: "10"
    name: "a very interesting card"
    """