ENV["RACK_ENV"] = "test"

require('capybara/rspec')
require('./app')
# require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('listing all the surveys', {:type => :feature}) do
  it('returns all existing surverys') do
    visit('/')
    expect(page).to have_content('Survey')
  end
end

describe('adding a new survey', {:type => :feature}) do
  it('adds a new survey') do
    visit('/')
    fill_in('survey_name', :with => 'What do you know?')
    click_button('Save Survey')
    expect(page).to have_content('What do you know?')
  end
end

describe('get info about a survey', {:type => :feature}) do
  it('displays information about a survey after selecting it') do
    visit('/')
    fill_in('survey_name', :with => 'What did you buy?')
    click_button('Save Survey')
    click_link('What did you buy?')
    expect(page).to have_content('Survey Info:')
  end
end

describe('add a question', {:type => :feature}) do
  it('will add a question to a survey and display it') do
    visit('/')
    fill_in('survey_name', :with => 'What did you eat?')
    click_button('Save Survey')
    click_link('What did you eat?')
    fill_in('new_question', :with => 'Where did you buy?')
    click_button('Save Question')
    expect(page).to have_content('Where did you buy?')
  end
end

describe('update survey name', {:type => :feature}) do
  it('will allow user to change survey name') do
    test_survey = Survey.create({:name => 'Another Survey'})
    @id = test_survey.id()
    visit('/survey_info/:id')
    fill_in('edit_survey', :with => 'Yet another survey')
    click_button('Update')
    expect(page).to have_content('Yet another survey')
  end
end
