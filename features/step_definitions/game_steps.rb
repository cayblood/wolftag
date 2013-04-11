Then /^player "(.*?)" should not be IT in game "(.*?)"$/ do |player_name, game_name|
  player = Player.find_by(name: player_name)
  game = Game.find_by(name: game_name)
  game.it_id.should_not == player.id
end

