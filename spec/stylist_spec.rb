require('spec_helper')

describe(Stylist) do
  describe('#first_name') do
    it('returns the first name of the stylist') do
      test_stylist = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(test_stylist.first_name()).to(eq("Bruce"))
    end
  end
  describe('#last_name') do
    it('returns the last name of the stylist') do
      test_stylist = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(test_stylist.last_name()).to(eq("Wayne"))
    end
  end
  describe('#phone_number') do
    it('returns the phone number of the stylist') do
      test_stylist = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(test_stylist.phone_number()).to(eq("5038675309"))
    end
  end
  describe('.all') do
    it('is empty at first') do
      expect(Stylist.all()).to(eq([]))
    end
  end
  describe('#==') do
    it('is the same stylist if it has the same name and phone number') do
      stylist1 = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      stylist2 = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      expect(stylist1).to(eq(stylist2))
    end
  end
  describe('#save') do
    it('lets you save a stylist into the database') do
      stylist = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end
  describe('#update') do
    it('lets you update stylists in the database') do
      stylist = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      stylist.save()
      stylist.update({:first_name => "Dick", :last_name => "Grayson", :phone_number => "5038675309"})
      expect(stylist.first_name()).to(eq("Dick"))
    end
  end
  describe('#delete') do
    it('deletes a book from the database') do
      stylist = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      stylist.save()
      stylist.delete()
      expect(Stylist.all()).to(eq([]))
    end
  end
  describe('.find') do
    it('returns a stylist by its ID') do
      stylist1 = Stylist.new({:first_name => "Bruce", :last_name => "Wayne", :phone_number => "5038675309", :id => nil})
      stylist1.save()
      stylist2 = Stylist.new({:first_name => "Dick", :last_name => "Grayson", :phone_number => "5038675309", :id => nil})
      stylist2.save()
      expect(Stylist.find(stylist1.id())).to(eq(stylist1))
    end
  end
end
