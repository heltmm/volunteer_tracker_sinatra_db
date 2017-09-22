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
      projects.push(Project.new({title: project['title'], id: project['id']}))
    end
    projects
  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING ID").first['id'].to_i
  end

  def ==

  end


end
