# ApiTestMongo

rake db:seed
rake db:seed RAILS_ENV=test

For shop lists:
GET http://127.0.0.1:3000/shops?publisher_id=

To buy book:
POST http://127.0.0.1:3000/purchases
params: shop_id, book_id=, copies=
