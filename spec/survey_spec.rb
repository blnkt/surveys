require 'spec_helper'

describe 'Survey' do
  it 'intitialize with a survey_name_id and a answers_questions_id' do
    new_question = Question.create({q_text: "Who are you?  Who-whoo?"})
    new_answer = Answer.create({a_text: "I am a lemon!", question_id: new_question.id})
    new_name = Survey_Name.create({name: "Mr. Awesome"})
    new_survey = Survey.create({question_id: new_question.id, survey_names_id: new_name.id})
  end
end
