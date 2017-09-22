class Project
  attr_reader :title, :id
  def initialize(project_hash)
    @title = project_hash[:title]
    @id = project_hash[:id]
  end

end
