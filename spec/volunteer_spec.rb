require ('spec_helper')

describe(Volunteer) do
  describe("#initialize") do
    it("is initialized with title and author") do
      volunteer1 = Volunteer.new({:name => "Quincy", :id => nil, :project_id => nil})
      expect(volunteer1.name()).to(eq("Quincy"))
    end
  end
  describe('.all') do
    it('is is empty to begin with') do
      expect(Volunteer.all()).to(eq([]))
    end
  end
  describe('#save') do
    it("adds a volunteer to the database")do
    volunteer1 = Volunteer.new({:name => "Quincy", :id => nil, :project_id => nil})
    volunteer1.save()
    expect(Volunteer.all()).to(eq([volunteer1]))
    end
  end
  describe ('.find') do
    it("returns a volunteer by its id number") do
      volunteer1 = Volunteer.new({:name => "Quincy", :id => nil, :project_id => nil})
      volunteer1.save()
      volunteer2 = Volunteer.new({:name => "Rowan", :id => nil, :project_id => nil})
      volunteer2.save()
      expect(Volunteer.find(volunteer2.id())).to(eq(volunteer2))
    end
  end
  describe(".update") do
    it("lets you assign new values to an entry") do
      volunteer1 = Volunteer.new({:name => "Quincy", :id => nil, :project_id => nil})
      volunteer1.save()
      volunteer1.update({:name => "Sierra", :id => nil, :project_id => nil})
      expect(volunteer1.name()).to(eq("Sierra"))
    end
  end

  # describe("#==") do
  #   it("is the same book if it matches ids") do
  #     volunteer1 = Volunteer.new({:name => "Quincy", :id => nil, :project_id => nil})
  #     volunteer1.save()
  #     volunteer2 = Volunteer.new({:name => "Quincy", :id => nil, :project_id => nil})
  #     volunteer2.save()
  #     expect(volunteer1).to(eq(volunteer2))
  #   end
  # end
end
