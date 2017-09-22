class Project
  attr_reader :title, :id

  def initialize(project_hash)
    @title = project_hash[:title]
    @id = project_hash[:id]
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects")
    projects = []
    returned_projects.each do |project|
      projects.push(Project.new({title: project['title'], id: project['id'].to_i}))
    end
    projects
  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING ID").first['id'].to_i
  end

  def ==(another_project)
    self.id.==(another_project.id) and self.title.==(another_project.title)
  end

  def self.find(id)
    found_project = DB.exec("SELECT * FROM projects WHERE id = #{id}").first
    Project.new({title: found_project['title'], id: found_project['id'].to_i})
  end

  def update(update_hash)
    @title = update_hash[:title]
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id}")
  end

  def volunteers
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id}")
    volunteers = []
    returned_volunteers.each do |volunteer|
      volunteers.push(Volunteer.new(:name => volunteer['name'], :project_id => volunteer['project_id'].to_i, :id => volunteer['id'].to_i))
    end
    volunteers
  end
end
