require('pg')
require_relative('../db/sql_runner')

class Store

  attr_accessor :id, :name, :stock_type

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @stock_type = options['stock_type']
    @address = options['address']
  end

  def save() 
    sql = "INSERT INTO stores (name, stock_type, address) VALUES ('#{@name}', '#{@stock_type}', '#{@address}') RETURNING *;"
    store = SqlRunner.run( sql ).first
    @id = store['id'].to_i
  end

  def pets()
    sql = "SELECT pets.* FROM pets WHERE store_id = #{@id}"
    pets = SqlRunner.run( sql )
    result = pets.map{ |pet| Pet.new(pet)}
    return result
  end 

  def self.find(id)
    sql = "SELECT * FROM stores WHERE id = #{id};"
    store = SqlRunner.run(sql).first
    result = Store.new(store)
  end 

  def self.all
    sql = "SELECT * FROM stores;"
    stores = SqlRunner.run(sql)
    result = stores.map{ |store| Store.new(store)}
      return result
  end

  def delete()
    sql = "DELETE FROM stores WHERE  
      id = #{@id};"
    SqlRunner.run(sql)
  end

  def update (options)
    @name = options['name'] if (options['name'])
    @stock_type = options['stock_type'] if (options['stock_type'] )
    @address = options['address'] if (options['address'])
    sql = "UPDATE stores SET
      name = '#{ @name }',
      stock_type = '#{ @stock_type }',
      address = '#{ @address }'
      WHERE id = #{ @id }"
    SqlRunner.run(sql)
  end

  # NB when running the file and in pry this is the type of thing you have to type in to update in the store store1.update('name' => 'My Pet Store')

end