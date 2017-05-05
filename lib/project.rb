class Project

  attr_accessor(:name,:id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(other_project)
    self.id == other_project.id
  end

  def self.all
    database_projects = DB.exec("SELECT * FROM projects;")
    all_projects = []
    database_projects.each() do |project|
      name = project["name"]
      id = project["id"].to_i()
      each_project = Project.new({:name => name, :id => id})
      all_volunteers.push(each_project)
    end
    all_volunteers
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    found_project = nil
    Project.all().each() do |project|
      if project.id() == id
        found_project = project
      end
    end
    found_project
  end

  def self.update(attributes)
    @name = attributes[:name]
    @id = self.id()
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end
