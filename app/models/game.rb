class Game
  include Mongoid::Document
  field :_id, type: String, default: -> { name.to_s.parameterize }
  field :name, type: String
  field :it_id, type: String
  belongs_to :it, class_name: :player, foreign_key: :it_id
  has_and_belongs_to_many :players

  validates_uniqueness_of :name
end
