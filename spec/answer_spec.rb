require 'spec_helper'

describe 'Answer' do
  it 'initiailize answer with text of answer' do
    new_answer = Answer.create({a_text: "I am a lemon!"})
    expect(new_answer).to be_an_instance_of Answer
  end
end
