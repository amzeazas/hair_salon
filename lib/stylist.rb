class Stylist
  attr_reader(:first_name, :last_name, :phone_number, :id)

  define_method(:initialize) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @id = attr.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      first_name = stylist.fetch("first_name")
      last_name = stylist.fetch("last_name")
      phone_number = stylist.fetch("phone_number")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :id => id}))
    end
    stylists
  end

  define_method(:==) do |another_stylist|
    self.first_name().==(another_stylist.first_name()) && self.last_name().==(another_stylist.last_name()) && self.phone_number.==(another_stylist.phone_number())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (first_name, last_name, phone_number) VALUES ('#{@first_name}', '#{@last_name}', '#{@phone_number}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:update) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @id = self.id()

    if @first_name != "" && @last_name != "" && @phone_number != ""
      DB.exec("UPDATE stylists SET first_name = '#{@first_name}', last_name = '#{@last_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @first_name != "" && @last_name != ""
      DB.exec("UPDATE stylists SET first_name = '#{@first_name}', last_name = '#{@last_name}' WHERE id = #{@id};")
    elsif @first_name != "" && @phone_number != ""
      DB.exec("UPDATE stylists SET first_name = '#{@first_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @last_name != "" && @phone_number != ""
      DB.exec("UPDATE stylists SET last_name = '#{@last_name}', phone_number = '#{@phone_number}' WHERE id = #{@id};")
    elsif @first_name != ""
      DB.exec("UPDATE stylists SET first_name = '#{@first_name}' WHERE id = #{@id};")
    elsif @last_name != ""
      DB.exec("UPDATE stylists SET last_name = '#{@last_name}' WHERE id = #{@id};")
    else
      DB.exec("UPDATE stylists SET phone_number = '#{@phone_number}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    found_stylist = []
    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  # define_method(:clients) do
  #   list_clients = []
  #   clients = DB.exec("SELECT * FROM clients WHERE stylists_id = #{self.id()};")
  #   clients.each() do |client|
  #     first_name = client.fetch("first_name")
  #     last_name = client.fetch("last_name")
  #     phone_number = client.fetch("phone_number")
  #     id = client.fetch("id")
  #     stylists_id = client.fetch("stylists_id").to_i()
  #     list_clients.push(Client.new({:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :id => id, :stylists_id => stylists_id}))
  #   end
  #   list_clients
  # end
end
