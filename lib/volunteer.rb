class Volunteer

  attr_accessor(:name,:id,:project_id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @project_id = attributes[:project_id]
  end

  def ==(other_volunteer)
  self.id == other_volunteer.id
end

  def self.all
    volunteers_in_database = DB.exec("SELECT * FROM volunteers;")
    all_volunteers = []
    volunteers_in_database.each() do |volunteer|
      name = volunteer["name"]
      id = volunteer["id"].to_i()
      project_id = volunteer["project_id"].to_i()
      each_volunteer = Volunteer.new({:name => name, :id => id, :project_id => project_id})
      all_volunteers.push(each_volunteer)
    end
    all_volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all().each() do |volunteer|
      if volunteer.id() == id
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  define_singleton_method(:update) do |attributes|
    @name = attributes[:name]
    @id = self.id()
    @project_id = self.project_id()
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end
