class Player
  include Mongoid::Document
  field :_id, type: String
  field :name, type: String
  has_and_belongs_to_many :games

  validates_uniqueness_of :name

  before_create :create_id

  private
  def create_id
    self.id = name.to_s.parameterize
  end
end
