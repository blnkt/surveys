require 'spec_helper'

describe 'Survey_Name' do
  it 'initializes a new survey name' do
    new_name = Survey_Name.create({name: "Mr. Awesome"})
    expect(new_name).to be_a Survey_Name
  end
end
