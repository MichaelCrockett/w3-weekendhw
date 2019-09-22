require_relative("../db/sql_runner")

class Film

  attr_accessor :id, :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
  end


  def save()
      sql = "INSERT INTO films
      (
        title,
        price
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@title, @price]
      films = SqlRunner.run( sql, values ).first
      @id = films['id'].to_i
end

    def Film.all()
      sql = "SELECT * FROM films"
      films = SqlRunner.run(sql)
      result = films.map { |film| Film.new( film ) }
      return result
    end

    def update()
        sql = "UPDATE films
        SET title=$1, price=$2 WHERE id=$3"
        values = [@title, @price, @id]
        SqlRunner.run( sql, values )
    end

    def delete()
      sql = "DELETE FROM films
      WHERE id = $1"
      values = [@id]
      SqlRunner.run( sql, values )
    end


    def all_customers_by_film
      sql = "SELECT customers.* FROM customers
            INNER JOIN screenings
            ON customers.id = screenings.film_id
            WHERE film_id = $1"
      values = [@id]
      customer_arr = SqlRunner.run( sql, values)
      result = customer_arr.map { |customer| Customer.new( customer ) }
      return result
    end

end #class end
