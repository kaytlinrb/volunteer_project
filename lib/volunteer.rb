class Volunteer

  attr_accessor(:name,:id,:project_id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @project_id = attributes[:project_id]
  end

  def ==(other_volunteer)
  self.name == other_volunteer.name

  def self.all
    volunteers_in_database = DB.exec("SELECT * FROM books;")
    all_volunteers = []
    volunteers_in_database.each() do |volunteer|
      name = volunteer["name"]
      id = volunteer["id"].to_i()
      project_id = volunteer["project_id"].to_i()
    end
    all_volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES #{@name} RETURNING id;")
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

  def update(attributes)
    @name = attributes[:title]
    @id = self.id()
    @volunteer_id = self.volunteer_id()
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end
