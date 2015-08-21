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

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

post('/stylists') do
  stylist = Stylist.new({:first_name => params.fetch("first_name"), :last_name => params.fetch("last_name"), :phone_number => params.fetch("phone_number")})
  stylist.save()
  redirect('/stylists')
end

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

patch("/stylist/:id") do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  phone_number = params.fetch("phone_number")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({:first_name => first_name, :last_name => last_name, :phone_number => phone_number})
  redirect('/stylists')
end

delete('/stylist/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  redirect('/stylists')
end

get('/clients') do
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

post('/clients') do
  client = Client.new({:first_name => params.fetch("first_name"), :last_name => params.fetch("last_name"), :phone_number => params.fetch("phone_number"), :stylists_id => params.fetch("stylists_id")})
  client.save()
  redirect('/clients')
end

get('/client/:id') do
  @client = Client.find(params.fetch("id").to_i())
  @stylists = Stylist.all()
  @stylist = Stylist.find(params.fetch("stylists_id").to_i())
  erb(:client)
end

patch("/client/:id") do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  phone_number = params.fetch("phone_number")
  stylists_id = params.fetch("stylists_id")
  @client = Client.find(params.fetch("id").to_i())
  @client.update({:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :stylists_id => stylists_id})
  redirect('/clients')
end

delete('/client/:id') do
  @client = Client.find(params.fetch("id").to_i())
  @client.delete()
  redirect('/clients')
end
