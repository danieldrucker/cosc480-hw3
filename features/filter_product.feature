Feature: Filter products by age and price
  As the toy store manager,
  so that I can sell a variety of toys,
  I want to be able to add new toys to the toy store.

  Background: the toy story has several products
    Given these Products:
      | name         |    description | price | minage | maxage |
      | slinky       | shiny          |  3.49 |  2     |        |
      | fluffy bunny | mostly lovable | 17.50 |  0     |  3     |
      | ball         | rubbery        | 13.49 |  3     |  6     |

  Scenario: filter by minimum age
    When I go to the products page
    And I fill in "age" with "2"
    And I press "Filter products"
    Then I should be on the products page
    And I should see "slinky"
    And I should see "fluffy bunny"
    But I should not see "ball"

  Scenario: filter by maximum price
    When I go to the products page
    And I fill in "price" with "3.50"
    And I press "Filter products"
    Then I should be on the products page
    And I should see "slinky"
    But I should not see "fluffy bunny"
    And I should not see "ball"

  Scenario: filter by minimum age and maximum price
    When I go to the products page
    And I fill in "price" with "13.50"
    And I fill in "age" with "3"
    And I press "Filter products"
    Then I should be on the products page
    And I should not see "slinky"
    But I should not see "fluffy bunny"
    And I should see "ball"

  Scenario: sort by price
    When I go to the products page
    And I press "Price"
    Then I should be on the products page
    Then I should see product price in sorted order

  Scenario: sort by name
    When I go to the products page
    And I press "Name"
    Then I should be on the products page
    Then I should see product name in sorted order

  Scenario: remember filter settings
    When I go to the products page
    And I fill in "price" with "3.50"
    And I press "Filter products"
    Then I should be on the products page
    When I press "Price"
    Then I should be on the products page
    And I should see product price in sorted order
    When I press "slinky"
    Then I go to the products page
    Then I should see product price in sorted order
    And I should see "slinky"
    But I should not see "fluffy bunny"
    And I should not see "ball"
