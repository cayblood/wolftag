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
    instance = model_class.new
    instance.id = attributes['id']
    instance.update_attributes(attributes)
    instance.save!
  end
end
World(CrudHelpers)

ENTITY_REGEX = /(game(?:s?))/
Given /^the following #{ENTITY_REGEX}:$/ do |entity_name, table|
  model_class = entity_name.as_entity
  table = table.transpose unless entity_name.plural?
  table.hashes.each do |attributes|
    update_attributes_from_cucumber_table(model_class, attributes)
  end
end

Given /^the following games: (.+)$/ do |games|
  games.split(", ").each do |game|
    Game.create!(name: game)
  end
end

Given /^the following players: (.+)$/ do |players|
  players.split(", ").each do |player|
    Player.create!(name: player)
  end
end

Given /^I have a session with id (.+)$/ do |player_id|
  session[:player] = player_id
end

When /^I visit (.*?)$/ do |path|
  visit path_to(path)
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, with: value)
end

When /^I press "([^\"]*)"$/ do |button|
  click_button(button)
end

Then /^I should be on (.*)$/ do |path|
  current_path.should == path_to(path)
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end
