require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/question')
require('./lib/survey')
require('pg')
require('pry')

get('/') do
  erb(:index)
end
