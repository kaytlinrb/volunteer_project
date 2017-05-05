require("rspec")
require("pg")
require("volunteer")
require("project")

DB = PG.connect({:dbname => 'volunteer_project_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("Delete FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
  end
end
