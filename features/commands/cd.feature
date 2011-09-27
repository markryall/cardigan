Feature: cd

  In order to manage my ideas
  As a command line junkie
  I want to be able to edit individual attributes of a card

  The cd command is so named because within the shell, you are 'changing directory' to
  edit a card.

  Within the cardigan shell, note that 'cd' enters a nested shell (so you need to exit or
  ctrl-d twice).

  Scenario: open a card for editing
    When I run `cardigan cd a very interesting card` interactively
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