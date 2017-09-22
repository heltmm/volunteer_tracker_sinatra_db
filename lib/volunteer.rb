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

  end

  def self.find(id)

  end

  def update(update_hash)

  end

  def delete

  end
end
