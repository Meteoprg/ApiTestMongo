class Shop
  include Mongoid::Document

  field :name
  
  has_many :vendor_codes
  
  def self.for_publisher(publisher_id)
    vendor_codes = VendorCode.where(publisher_id: publisher_id).order_by(book_id: 1).to_a
    return I18n.t('errors.nothing_found').to_json if vendor_codes.blank?
    books = Book.where(:id.in => vendor_codes.map(&:book_id)).order_by(id: 1).to_a
    shops = {}
    Shop.where(:id.in => vendor_codes.map(&:shop_id)).each {|shop| shops[shop.id] = shop.as_json.merge(books_in_stock: [])}
    current_book_i = 0
    vendor_codes.each do |vendor_code|
      next if vendor_code.copies_in_stock == 0
      current_book_i += 1 if vendor_code.book_id != books[current_book_i].id
      item = { id: vendor_code.book_id, title: books[current_book_i].title, copies_in_stock: vendor_code.copies_in_stock }
      shops[vendor_code.shop_id][:books_in_stock].push(item)
    end
    result = SalesTable.where(publisher_id: publisher_id).order_by(sales: -1).map do |pair|
      shops.delete(pair.shop_id).merge(sales: pair.sales)
    end + shops.to_a
    {}.merge(Shops: result)
  end

end