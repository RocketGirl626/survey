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

get('/question/:id') do
  @question = Question.find(params.fetch('id'))
  erb(:question_info)
end

patch('/question/:id') do
  @id = params.fetch('id')
  @question = Question.find(params.fetch('id'))
  survey_id = @question.survey_id()
  @question.update({:inquiry => params.fetch('edit_question'), :survey_id => survey_id})
  erb(:question_info)
end

delete('/question/:id') do
  @question = Question.find(params.fetch('id'))
  survey_id = @question.survey_id()
  @question.destroy()
  @survey = Survey.find(survey_id)
  @questions = @survey.questions()
  erb(:survey_info)
end

patch('/survey/:id') do
  @id = params.fetch('id')
  @survey = Survey.find(@id)
  @survey.update(:name => params.fetch('edit_survey'))
  @questions = @survey.questions()
  erb(:survey_info)
end

delete('/survey/:id') do
  @survey = Survey.find(params.fetch('id'))
  @survey.destroy()
  @surveys = Survey.all()
  erb(:index)
end
