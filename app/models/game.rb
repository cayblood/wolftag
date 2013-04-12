class Game
  include Mongoid::Document
  field :_id, type: String, default: -> { name.to_s.parameterize }
  field :name, type: String
  belongs_to :it, class_name: "Player", inverse_of: nil
  has_and_belongs_to_many :players

  validates_uniqueness_of :name
end
