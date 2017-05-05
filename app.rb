require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_project"})


get ('/') do
  erb(:index)
end

get('/project/new') do
  erb(:project_form)
end

post('/projects') do
  # name = params.fetch('name')
  # project = Project.new({:name => name, :id => nil})
  # project.save()
  # @projects = Project.all()
  erb(:success)
end
