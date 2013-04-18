class Game
  include Mongoid::Document
  field :name, type: String
  belongs_to :it, class_name: "Player", inverse_of: nil
  has_and_belongs_to_many :players

  validates_uniqueness_of :name

  before_create :create_id

  private
  def create_id
   self.id = name.to_s.parameterize
  end
end
