require 'spec_helper'

describe 'Answers_Questions' do
  it 'initiailize question with text of question' do
    new_question = Question.create({q_text: "Who are you?  Who-whoo?"})
    new_answer = Answer.create({a_text: "I am a lemon!"})
    new_join = Answers_Questions.create({questions_id: new_question.id, answers_id: new_answer.id})
    expect(new_join).to be_an_instance_of Answers_Questions
  end
end
