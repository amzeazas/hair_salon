class Client
  attr_reader(:first_name, :last_name, :phone_number, :id)

  define_method(:initialize) do |attr|
    @first_name = attr.fetch(:first_name)
    @last_name = attr.fetch(:last_name)
    @phone_number = attr.fetch(:phone_number)
    @id = attr.fetch(:id, nil)
  end
end
