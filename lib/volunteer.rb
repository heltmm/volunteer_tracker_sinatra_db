class Volunteer
  attr_reader :name, :id, :project_id

  def initialize(volunteer_hash)
    @name = volunteer_hash[:name]
    @id = volunteer_hash[:id]
    @project_id = volunteer_hash[:project_id]
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each do |volunteer|
      volunteers.push(Volunteer.new(name: volunteer['name'], id: volunteer['id'].to_i, project_id: volunteer['project_id'].to_i))
    end
    volunteers
  end

  def save
    @id  = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING ID").first['id'].to_i
  end

  def ==(another_volunteer)
    self.id.==(another_volunteer.id) and self.name.==(another_volunteer.name) and self.project_id.==(another_volunteer.project_id)
  end

  def self.find(id)
    found_volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id}").first
    Volunteer.new(name: found_volunteer['name'], id: found_volunteer['id'].to_i, project_id: found_volunteer['project_id'].to_i)
  end

  def update(update_hash)
    @name = update_hash[:name]
    @project_id = update_hash[:project_id]
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id}")
  end
end
