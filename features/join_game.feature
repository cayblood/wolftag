Feature: Joining a new game
  In order to have fun with my friends
  As an interested person
  I want to join a game of tag

  Background:
    Given the following games:
      | id | name             | slug             | it_id |
      | 1  | Cool game of tag | cool-game-of-tag |       |
    And the following players:
      | id | game_id | name   | session_id |
      | 1  | 1       | Carl   | 1          |
      | 2  | 1       | George | 2          |

  Scenario: A new player joins
    When I visit "/games/cool-game-of-tag/join"
    And I fill in "Name" with "Bill"
    Then I should see "Welcome Bill"
