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

Given /^there are the following games:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given /^there are the following players:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I visit "(.*?)"$/ do |url|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end