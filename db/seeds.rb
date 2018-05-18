publishers = Publisher.create([{ name: 'First publisher' }, { name: 'Second publisher' }, {name: "Third Publisher"}])
200.times do |i|
  b = Book.new(title: "Book#{i}")
  Publisher.first.books << b
end
50.times {Shop.create}
books = Book.all
shops = Shop.all
Shop.all.each do |s|
  i = rand(1..194)
  5.times do 
    vc = VendorCode.new(copies_in_stock:20)
    books[i].vendor_codes << vc
    s.vendor_codes << vc
    i += 1
  end
end
