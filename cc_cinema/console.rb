require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/screening' )
require_relative( 'models/ticket' )

require( 'pry' )

Customer.delete_all()
Film.delete_all()
Screening.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'Mike',
  'funds' => 50 })

customer2 = Customer.new({
  'name' => 'Shona',
  'funds' => 60 })

customer3 = Customer.new({
  'name' => 'Roddy',
  'funds' => 70 })

customer1.save()
customer2.save()
customer3.save()


film1 = Film.new({
  'title' => 'Gladiator',
  'price' => 10})

film2 = Film.new({
  'title' => 'Titanic',
  'price' => 15})

film3 = Film.new({
  'title' => 'Everest',
  'price' => 20})

film1.save()
film2.save()
film3.save()

all_films = Film.all
all_customers = Customer.all

# film1.title = 'Gladiator 2'
# film1.update
#
# customer1.name = "Michael"
# customer1.update

screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => "2019-09-20 16:00:00"
})

screening2 = Screening.new({
  'film_id' => film3.id,
  'screening_time' => "2019-09-20 18:00:00"
})

screening3 = Screening.new({
  'film_id' => film2.id,
  'screening_time' => "2019-09-20 20:00:00"
})

screening1.save
screening2.save
screening3.save


# screening3.film_id = film2.id
# screening3.update
# screening2.delete




ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening3.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening1.id
  })

ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'screening_id' => screening2.id
  })

ticket1.save
ticket2.save
ticket3.save

# ticket2.customer_id = customer3.id
# ticket2.update

# ticket3.delete


binding.pry
nil
