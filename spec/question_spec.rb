require 'spec_helper'

describe 'Question' do
  it 'initiailize question with text of question' do
    new_question = Question.create({q_text: "Who are you?  Who-whoo?"})
    expect(new_question).to be_an_instance_of Question
  end
end
