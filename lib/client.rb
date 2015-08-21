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

  define_method(:==) do |another_client|
    self.first_name().==(another_client.first_name()) && self.last_name().==(another_client.last_name()) && self.phone_number.==(another_client.phone_number())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (first_name, last_name, phone_number) VALUES ('#{@first_name}', '#{@last_name}', '#{@phone_number}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:update) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @id = self.id()

    if @first_name != "" && @last_name != "" && @phone_number != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @first_name != "" && @last_name != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}' WHERE id = #{@id};")
    elsif @first_name != "" && @phone_number != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @last_name != "" && @phone_number != ""
      DB.exec("UPDATE clients SET last_name = '#{@last_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @first_name != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}' WHERE id = #{@id};")
    elsif @last_name != ""
      DB.exec("UPDATE clients SET last_name = '#{@last_name}' WHERE id = #{@id};")
    else
      DB.exec("UPDATE clients SET phone_number = '#{@phone_number}' WHERE id = #{@id};")
    end
  end
end
