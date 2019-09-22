require_relative("../db/sql_runner")

class Ticket
  attr_accessor :id, :screening_id, :customer_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screening_id = options['screening_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def self.delete_all()
      sql = "DELETE FROM tickets"
      SqlRunner.run(sql)
  end

  def save()
  sql = "INSERT INTO tickets
  (
    customer_id,
    screening_id
  )
  VALUES
  (
    $1, $2
  )
  RETURNING id"
  values = [@customer_id, @screening_id,]
  tickets = SqlRunner.run( sql,values ).first
  @id = tickets['id'].to_i
end

def Ticket.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  result = tickets.map { |tickets| Ticket.new( tickets ) }
  return result
end

def update()
  sql = "UPDATE tickets
  SET screening_id=$1, customer_id=$2 WHERE id=$3"
  values = [@screening_id, @customer_id, @id]
  SqlRunner.run( sql, values )
end


def delete()
  sql = "DELETE FROM tickets
  WHERE id = $1"
  values = [@id]
  SqlRunner.run( sql, values )
end






end #class end
