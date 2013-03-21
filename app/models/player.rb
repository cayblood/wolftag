class Player
  include Mongoid::Document
  field :_id, type: String, default: -> { name.to_s.parameterize }
  field :name, type: String
  has_and_belongs_to_many :games

  validates_uniqueness_of :name
end
