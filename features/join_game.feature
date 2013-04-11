Feature: Joining a new game
  In order to have fun with my friends
  As an interested person
  I want to join a game of tag

  Background:
    #Given the following games:
    #  | id | name             | it_id |
    #  | 1  | Cool game of tag |       |
    #And the following players:
    #  | id | game_id          | name   |
    #  | 1  | cool_game_of_tag | Carl   |
    #  | 2  | cool_game_of_tag | George |
    Given the following games: Cool game of tag
    And the following players: Nico, David, Morten

  Scenario: Login with no session
    When I visit the homepage
    Then I should be on new player

  Scenario: Login with session
    When I visit the homepage
    And I fill in 'Name' with 'Nico'
    And I press "Add me"
    Then I should be on the list of games 
    And I should see "Logged in as: Nico."
    And I should see "Cool game of tag"

  Scenario: Join a game
    Given I am logged in as Nico
    When I visit the homepage
    And I follow Cool game of tag
    And I press "Join"
    Then "Cool game of tag" should have 1 player
    And player "Nico" should be a part of 1 game "Cool game of tag"
    And I should see "Welcome to Cool game of tag, Nico" 
    And player "Nico" should not be IT in game "Cool game of tag"

