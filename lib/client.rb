class Client
  attr_reader(:first_name, :last_name, :phone_number, :id, :stylists_id)

  define_method(:initialize) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @id = attr.fetch(:id, nil)
    @stylists_id = attr.fetch(:stylists_id)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      first_name = client.fetch("first_name")
      last_name = client.fetch("last_name")
      phone_number = client.fetch("phone_number")
      id = client.fetch("id").to_i()
      stylists_id = client.fetch("stylists_id").to_i()
      clients.push(Client.new({:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :id => id, :stylists_id => stylists_id}))
    end
    clients
  end

  define_method(:==) do |another_client|
    self.first_name().==(another_client.first_name()) && self.last_name().==(another_client.last_name()) && self.phone_number.==(another_client.phone_number()) && self.stylists_id.==(another_client.stylists_id())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (first_name, last_name, phone_number, stylists_id) VALUES ('#{@first_name}', '#{@last_name}', '#{@phone_number}', '#{@stylists_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:update) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @stylists_id = attr.fetch(:stylists_id)
    @id = self.id()

    if @first_name != "" && @last_name != "" && @phone_number != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}', phone_number = '#{@phone_number}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @first_name != "" && @last_name != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @first_name != "" && @phone_number != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', phone_number = '#{@phone_number}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @first_name != "" && @last_name != "" && @phone_number != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @last_name != "" && @phone_number != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET last_name = '#{@last_name}', phone_number = '#{@phone_number}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @first_name != "" && @last_name != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', last_name = '#{@last_name}' WHERE id = #{@id};")
    elsif @first_name != "" && @phone_number != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @first_name != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @last_name != "" && @phone_number != ""
      DB.exec("UPDATE clients SET last_name = '#{@last_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @last_name != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET last_name = '#{@last_name}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @phone_number != "" && @stylists_id != ""
      DB.exec("UPDATE clients SET phone_number = '#{@phone_number}', stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    elsif @first_name != ""
      DB.exec("UPDATE clients SET first_name = '#{@first_name}' WHERE id = #{@id};")
    elsif @last_name != ""
      DB.exec("UPDATE clients SET last_name = '#{@last_name}' WHERE id = #{@id};")
    elsif @phone_number != ""
      DB.exec("UPDATE clients SET phone_number = '#{@phone_number}' WHERE id = #{@id};")
    else
      DB.exec("UPDATE clients SET stylists_id = '#{@stylists_id}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    found_client = []
    Client.all().each() do |client|
      if client.id().==(id)
        found_client = client
      end
    end
    found_client
  end

  define_method(:stylist) do
    list_stylists = []
    stylists = DB.exec("SELECT * FROM stylists WHERE id = #{self.stylists_id()};")
    stylists.each() do |stylist|
      first_name = stylist.fetch("first_name")
      last_name = stylist.fetch("last_name")
      phone_number = stylist.fetch("phone_number")
      id = stylist.fetch("id")
      list_stylists.push(Stylist.new({:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :id => id}))
    end
    list_stylists
  end
end
