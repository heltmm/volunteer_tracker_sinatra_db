
require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload '.lib/**/*.rb'
require './lib/project'
require './lib/volunteer'
require 'pg'

DB = PG.connect({dbname: 'volunteer_tracker'})

#seed database with an unassgined project that will not show up on page
Project.new({:title => "Unassigned"}).save

get ('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:home)
end

post('/projects') do
  Project.new({:title => params['title']}).save
  redirect('/')
end

post('/volunteer') do
  Volunteer.new({:name => params['name'], :project_id => params['project_id']}).save
  redirect('/')
end

get('/projects/:id') do
  @project = Project.find(params[:id])
  erb(:project)
end

post('/projects/delete/:id') do
  project = Project.find(params[:id])
  project.delete
  redirect('/')
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id])
  erb(:project_update)
end

post('/projects/:id/edit') do
  @project = Project.find(params[:id])
  @project.update({:title => params['title']})
  redirect('/')
end

get('/volunteer/:id') do
  @projects = Project.all
  @volunteer = Volunteer.find(params[:id])
  erb(:volunteer)
end

post('/volunteer/update/:id') do
  @projects = Project.all
  @volunteer = Volunteer.find(params[:id])
  @volunteer.update({:name => params['name'], :project_id => params['project_id']})
  redirect('/')
end

post('/volunteer/delete/:id') do
  volunteer = Volunteer.find(params[:id])
  volunteer.delete
  redirect('/')
end
