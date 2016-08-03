require('pg')
require_relative('../db/sql_runner')

class Pet

  attr_accessor :id, :store_id, :name

  def initialize(options)
    @id = options['id'].to_i
    @store_id = options['store_id'].to_i
    @name = options['name']
    @type = options['type']
  end

  def save()
    sql = "INSERT INTO pets (name, store_id) VALUES ('#{@name}', #{@store_id}) RETURNING *;"
    pet = SqlRunner.run( sql ).first
    @id = pet['id'].to_i
  end

  def store()
    sql = "SELECT stores.* FROM stores WHERE id = '#{@store_id}'"
    store = SqlRunner.run( sql ).first
    store = Store.new(store)
  end


  def update (options)
    @name = options['name'] if (options['name'])
    @type = options['type'] if (options['type'] )
    @store_id = options['store_id'] if (options['store_id'])
    sql = "UPDATE pets SET
      name = '#{ @name }',
      type = '#{ @type }',
      store_id = '#{ @store_id }'
      WHERE id = #{ @id }"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM pets WHERE  
      id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM pets;"
    pets = SqlRunner.run(sql)
    result = pets.map{ |pet| Pet.new(pet)}
      return result
  end

end