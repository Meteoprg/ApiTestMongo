class SalesTable
  include Mongoid::Document

  belongs_to :shop
  belongs_to :publisher

  field :sales, type: Integer, default: 0

  index({ publisher_id: 1, sales: -1 })
end