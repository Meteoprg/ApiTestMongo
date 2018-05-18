class Publisher
  include Mongoid::Document

  has_many :books

  field :name

  validates :name, presence: true
  
end
