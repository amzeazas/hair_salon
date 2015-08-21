require('spec_helper')

describe(Client) do
  describe('#first_name') do
    it('returns the first name of the client') do
      test_client = Client.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(test_client.first_name()).to(eq("Bruce"))
    end
  end
  describe('#last_name') do
    it('returns the last name of the client') do
      test_client = Client.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(test_client.last_name()).to(eq("Wayne"))
    end
  end
  describe('#phone_number') do
    it('returns the phone number of the client') do
      test_client = Client.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(test_client.phone_number()).to(eq("5038675309"))
    end
  end
  describe('.all') do
    it('is empty at first') do
      expect(Client.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('lets you save a client into the database') do
      client = Client.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      client.save()
      expect(Client.all()).to(eq([client]))
    end
  end
end
