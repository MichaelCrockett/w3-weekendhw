require_relative("../db/sql_runner")

class Screening

  attr_accessor :id, :film_id

    def initialize( options )
      @id = options['id'].to_i if options['id']
      @film_id = options['film_id'].to_i
      @screening_time = options['screening_time']
    end

    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
      end

    def save()
    sql = "INSERT INTO screenings
    (
      film_id,
      screening_time
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@film_id, @screening_time,]
    screenings = SqlRunner.run( sql,values ).first
    @id = screenings['id'].to_i
  end


  def Screening.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    result = screenings.map { |screening| Screening.new( screening ) }
    return result
  end

  def update()
    sql = "UPDATE screenings
    SET film_id=$1, screening_time=$2 WHERE id=$3"
    values = [@film_id, @screening_time, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end




end #class end
