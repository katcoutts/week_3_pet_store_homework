require_relative('./models/pet')
require_relative('./models/store')

require('pry-byebug')

store1 = Store.new({ 'name' => 'My Pet Shop', 'stock_type' => 'Cuddly', 'address' => '1 Argyle Street'})
store2 = Store.new({ 'name' => '2nd Pet Shop', 'stock_type' => 'Spiky', 'address' => '1 Turner Street'})
store3 = Store.new({ 'name' => '3rd Pet Shop', 'stock_type' => 'Fish', 'address' => '1 Castle Street'})
store1.save()
store2.save()
store3.save()


pet1 = Pet.new({'name' => 'Chewie', 'store_id' => store1.id, 'type' => 'cat'})
pet2 = Pet.new({'name' => 'Michael', 'store_id' => store1.id, 'type' => 'fish'})
pet1.save
pet2.save

binding.pry
nil