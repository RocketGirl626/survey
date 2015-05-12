require('spec_helper')

describe(Survey) do
  describe('#question') do
    it('returns the questions belonging to a survey') do
      test_survey = Survey.create({:name => 'Computer Survey'})
      test_question = Question.create({:inquiry => 'Do you like computers?', :survey_id => test_survey.id()})
      test_question2 = Question.create({:inquiry => 'Do you like ActiveRecord?', :survey_id => test_survey.id()})
      expect(test_survey.questions()).to(eq([test_question, test_question2]))
    end
  end
end
