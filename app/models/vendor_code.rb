class VendorCode
  include Mongoid::Document

  before_create :set_publisher_id


  belongs_to :book
  belongs_to :shop
  has_many :purchases

  field :publisher_id, type: String
  field :copies_in_stock, type: Integer, default: 0
  field :books_sold_count, type: Integer, default: 0

  validate :check_publisher_id, on: :update
  validate :check_uniq, on: :create
  validates :book, presence: true
  validates :shop, presence: true
  validates :copies_in_stock, :numericality => { :greater_than_or_equal_to => 0 }, on: :create

  index({ publisher_id: 1, book_id: 1 })

  private

  def check_publisher_id
    errors.add(:publisher_id, I18n.t('errors.publisher_ids_equal')) unless publisher_id == book.publisher_id.to_s        
  end

  def check_uniq
    errors.add(:shop_id, I18n.t('errors.uniq')) if VendorCode.where(book_id: book_id, shop_id: shop_id).count > 0
  end

  def set_publisher_id
    set(:publisher_id, book.publisher_id.to_s)
  end

end