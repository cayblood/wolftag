class String
  def plural?
    self.pluralize == self and self.singularize != self
  end

  def as_entity
    self.gsub(/\s+/, '_').classify.constantize
  end
end

module CrudHelpers
  def update_attributes_from_cucumber_table(model_class, attributes)
    instance = model_class.new(attributes)
    instance.save!
  end
end
World(CrudHelpers)

ENTITY_REGEX = /(.*?)/
Given /^the following #{ENTITY_REGEX}:$/ do |entity_name, table|
  model_class = entity_name.as_entity
  table = table.transpose unless entity_name.plural?
  table.hashes.each do |attributes|
    update_attributes_from_cucumber_table(model_class, attributes)
  end
end

Given /^I have a session with id (.+)$/ do |player_id|
  session[:player] = player_id
end

When /^I visit (.*?)$/ do |path|
  visit path_to(path)
end

When /^I fill in '([^\"]*)' with '([^\"]*)'$/ do |field, value|
  fill_in(field, with: value)
end

When /^I press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^I follow "([^\"]*)"$/ do |link|
  click_link(link)
end

Then /^I should be on (.*)$/ do |path|
  current_path.should == path_to(path)
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Given /^I am logged in as (.+)$/ do |player_name|
  step "I visit the homepage"
  step "I fill in 'Name' with '#{player_name}'"
  step 'I press "Add me"'
end

Then /^"(.*?)" should have (\d+) player$/ do |game_name, player_count|
  game = Game.find_by(name: game_name)
  game.players.count.should == player_count.to_i
end

Then /^player "(.*?)" should be a part of (\d+) game "(.*?)"$/ do |player_name, games_count, game_name|
  player = Player.find_by(name: player_name)
  player.games.count.should == games_count.to_i
  game = Game.find_by(name: game_name)
  player.games.map(&:name).should include(game.name)
end
