require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})


get ('/') do
  erb(:index)
end

get('/project/new') do
  erb(:project_form)
end

post('/projects') do
  name = params.fetch('name')
  project = Project.new({:name => name, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:index)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get('/projects/:id') do
  project_id = params.fetch('id').to_i()
  @project = Project.find(project_id)
  erb(:project)
end

delete('/project/:id/delete') do
  @project = Project.find(params.fetch('id').to_i())
  @project.delete()
  @projects = Project.all()
  erb(:projects)
end

get('/project/:id/update') do
  @project = Project.find(params.fetch('id').to_i())
  erb(:project_update_form)
end

patch('/project/:id/update/confirm') do
  name = params.fetch("new_name")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:name => name})
  erb(:project)
end

get('/project/:id/add_volunteer') do
  @project = Project.find(params.fetch("id").to_i())
  erb(:volunteer_form)
end

post('/project/:id/volunteers/new') do
  @project = Project.find(params.fetch("id").to_i())
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  name = params.fetch('name')
  volunteer = Volunteer.new({:name => name, :id => nil, :project_id => params.fetch('name').to_i()})
  volunteer.save()
  @volunteers = Volunteer.all()
  erb(:project)
end

get('/volunteers') do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params.fetch('id').to_i())
  erb(:volunteer)
end

delete('/volunteer/:id/delete') do
  @volunteer = Volunteer.find(params.fetch('id').to_i())
  @volunteer.delete()
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

patch('/volunteer/:id/update/confirm') do
  name = params.fetch("new_name")
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteer.update({:name => name})
  erb(:volunteers)
end
