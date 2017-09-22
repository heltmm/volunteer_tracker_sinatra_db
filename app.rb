
require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload '.lib/**/*.rb'
require './lib/project'
require './lib/volunteer'
require 'pg'

DB = PG.connect({dbname: 'volunteer_tracker'})

get ('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:home)
end

get('/project') do
  redirect('/')
end

post('/project') do
  Project.new({:title => params['title']}).save
  redirect('/')
end

get('/volunteer') do
  redirect('/')
end

post('/volunteer') do
  Volunteer.new({:name => params['name'], :project_id => params['project_id']}).save
  redirect('/')
end
