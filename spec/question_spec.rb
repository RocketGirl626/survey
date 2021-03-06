require("spec_helper")

describe(Question) do
  describe('#survey') do
    it("tells which survey it belongs to") do
      test_survey = Survey.create({:name => "computer survey"})
      test_question = Question.create({:inquiry => "Do you like computers?", :survey_id => test_survey.id})
      expect(test_question.survey).to(eq(test_survey))
    end
  end
end
