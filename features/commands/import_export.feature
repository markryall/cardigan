Feature: import and export

  In order to interoperate with other tracking systems
  As a command line junkie
  I want to roundtrip import and export my cards

  Scenario: import cards containing ids from csv
    Given a file named "cards1.csv" with:
    """
    id,name,estimate
    10,qwer,1
    11,adsf,2
    12,zxcv,3
    """
    When I run `cardigan import cards1`
    And I run `cardigan ls`
    And I run `cardigan export cards2`
    Then the exit status should be 0
    And the stdout should contain:
    """
     --------------
    | index | name |
     --------------
    | 1     | adsf |
    | 2     | qwer |
    | 3     | zxcv |
     --------------
    """
    And the file "cards2.csv" should contain "id,estimate,name"
    And the file "cards2.csv" should contain "10,1,qwer"
    And the file "cards2.csv" should contain "11,2,adsf"
    And the file "cards2.csv" should contain "12,3,zxcv"

  Scenario: export cards to csv
    When I run `cardigan touch qwer`
    And I run `cardigan touch asdf`
    And I run `cardigan touch zxcv`
    And I run `cardigan export cards`
    Then the exit status should be 0
    And the file "cards.csv" should match /^id,name$/
    And the file "cards.csv" should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12},qwer$/
    And the file "cards.csv" should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12},asdf$/
    And the file "cards.csv" should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12},zxcv$/