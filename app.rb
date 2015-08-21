require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
also_reload('lib/**/*.rb')
require('pg')
require('pry')
require('launchy')

DB = PG.connect({:dbname => "hair_salon_test"})

get('/') do
  erb(:index)
end
