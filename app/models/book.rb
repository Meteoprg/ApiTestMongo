class Book
  include Mongoid::Document

  belongs_to :publisher
  has_many :vendor_codes

  field :title, type: String

  validates :publisher, presence: true
  validates :title, presence: true

end
