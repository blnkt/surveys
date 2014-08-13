require 'active_record'
require './lib/answer'
require './lib/question'
require './lib/survey'
require './lib/history'
require './lib/survey_name'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(test_configuration)

def header
  puts "*" * 50
  puts "Super Survey Taker 5000"
  puts "*" * 50
  puts "\n"
end

def main_menu
  header
  puts "A > Add a survey"
  puts "T > Take a survey"
  puts "E > Exit"
  choice = gets.chomp.upcase
  case choice
  when 'A'
    add_survey
  when 'T'
    take_survey
  when 'E'
    puts "Have an excellent day!"
    exit
  else
    puts 'Invalid input. Try again.'
  end
  main_menu
end

def add_survey
  puts "Please enter name of new survey:"
  name = gets.chomp.capitalize
  new_survey = Survey_Name.create({name: name})
  loop do
    puts "Enter survey question:"
    question = gets.chomp.capitalize
    new_question = Question.create({q_text: question})
    loop do
      puts "Add a potential answer to your question:"
      answer = gets.chomp.capitalize
      new_answer = Answer.create({a_text: answer})
      @join = Answers_Questions.create({questions_id: new_question.id, answers_id: new_answer.id})
      puts "Add another potential answer? (Y/N)"
      choice = gets.chomp.upcase
      break if choice == "N"
    end
    survey = Survey.create({answers_questions_id: @join.id, survey_names_id: new_survey.id})
    puts "Add another question? (Y/N)"
      q_choice = gets.chomp.upcase
      break if q_choice == "N"
  end
  puts "Survey '#{new_survey.name}' is now available!"
end

def take_survey
  view_surveys
  puts "Enter a survey ID to take the survey"
  input = gets.chomp.to_i
  a = []
  Survey.where(survey_names_id: input).each do |survey|
    # Answers_Questions.where(id: survey.answers_questions_id).each do |question|
    #   puts Questions.find(id: question.questions_id).q_text
    #   Answer.where()
    @q = survey.answers_questions.questions.q_text
    a << survey.answers_questions.answers.a_text
  end
  puts @q
  a.each do |answer|
    puts answer
  end
  gets
end

def view_surveys
end


main_menu
