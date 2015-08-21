class Client
  attr_reader(:first_name, :last_name, :phone_number, :id)

  define_method(:initialize) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @id = attr.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      first_name = client.fetch("first_name")
      last_name = client.fetch("last_name")
      phone_number = client.fetch("phone_number")
      id = client.fetch("id").to_i()
      clients.push(Client.new({:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :id => id}))
    end
    clients
  end
end
