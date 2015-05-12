require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/question')
require('./lib/survey')
require('pg')
require('pry')

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/survey_save/') do
  @survey_name = params.fetch('survey_name')
  Survey.create({:name => @survey_name})
  @surveys = Survey.all()
  erb(:index)
end

get('/survey/:id') do
  @survey = Survey.find(params.fetch('id'))
  @questions = @survey.questions()
  erb(:survey_info)
end

post('/survey/:id') do
  @survey = Survey.find(params.fetch('id'))
  @new_question = Question.create({:inquiry => params.fetch('new_question'), :survey_id => params.fetch('id')})
  @questions = @survey.questions()
  erb(:survey_info)
end
