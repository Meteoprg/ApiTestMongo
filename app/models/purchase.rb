class Purchase
  include Mongoid::Document

  after_create :buy

  belongs_to :vendor_code

  field :copies, type: Integer, default: 0

  validates :copies, :numericality => { :greater_than_or_equal_to => 0 }, on: :create
  validate :check_count, on: :create
  validates :vendor_code, presence: true

  def self.for_params(params)
    if (vendor_code = VendorCode.where(book_id: params[:book_id], shop_id: params[:shop_id]).first) && (shop = Shop.where(id: params[:shop_id]).first)
      transaction = Purchase.new(copies: params[:copies])
      vendor_code.purchases << transaction
      if transaction.errors.blank?
        item = SalesTable.find_or_create_by(shop_id: shop.id, publisher_id: vendor_code.publisher_id)
        sales = item.sales + transaction.copies
        item.update_attributes(sales: sales)
        transaction.to_json 
      else
         transaction.errors.full_messages.to_json
      end
    else
      I18n.t('errors.nothing_found').to_json
    end
  end

  private 
  
  def buy 
    vendor_code.update_attributes(copies_in_stock: vendor_code.copies_in_stock - copies, books_sold_count: vendor_code.books_sold_count + copies)

  end

  def check_count
    errors.add(:count, I18n.t('errors.copies_count')) if vendor_code.present? && copies > vendor_code.copies_in_stock
  end
end