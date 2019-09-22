require_relative("../db/sql_runner")

class Customer

  attr_accessor :id, :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end


  def save()
      sql = "INSERT INTO customers
      (
        name,
        funds
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@name, @funds]
      customers = SqlRunner.run( sql, values ).first
      @id = customers['id'].to_i
    end

    def Customer.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      result = customers.map { |customer| Customer.new( customer ) }
      return result
    end

    def update()
        sql = "UPDATE customers
        SET name=$1, funds=$2 WHERE id=$3"
        values = [@name, @funds, @id]
        SqlRunner.run( sql, values )
    end

    def delete()
      sql = "DELETE FROM customers
      WHERE id = $1"
      values = [@id]
      SqlRunner.run( sql, values )
    end

    def all_films_by_customer
      sql = "SELECT films.* FROM films
            INNER JOIN tickets
            ON films.id = tickets.screening_id
            WHERE customer_id = $1"
      values = [@id]
      film_arr = SqlRunner.run( sql, values)
      result = film_arr.map { |film| Film.new( film ) }
      return result
    end

end #class end
