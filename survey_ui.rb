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
  system 'clear'
  puts "*" * 50
  puts "Super Survey Taker 5000"
  puts "*" * 50
  puts "\n"
end

def main_menu
  header
  puts "A > Add a survey"
  puts "T > Take a survey"
  puts "S > Survey stats"
  puts "E > Exit"
  choice = gets.chomp.upcase
  case choice
  when 'A'
    add_survey
  when 'T'
    take_survey
  when 'S'
    survey_stats
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
  survey_name = Survey_Name.create({name: name})
  survey = Survey.create({survey_names_id: survey_name})
  loop do
    puts "Enter survey question:"
    question_text = gets.chomp.capitalize
    new_question = survey.questions.create({q_text: question_text})
    loop do
      puts "Add a potential answer to your question:"
      answer = gets.chomp.capitalize
      new_question.answers.create({a_text: answer, question_id: new_question.id})
      puts "Add another potential answer? (Y/N)"
      choice = gets.chomp.upcase
      break if choice == "N"
    end
    survey.update({question_id: new_question.id})
    puts "Add another question? (Y/N)"
      q_choice = gets.chomp.upcase
      break if q_choice == "N"
  end
  puts "Survey '#{survey.name}' is now available!"
end

def take_survey
  view_surveys
  puts "Enter a survey ID to take the survey"
  input = gets.chomp.to_i
  Survey.where({survey_names_id: input}).each do |survey|
    Question.where({id: survey.question_id}).each do |question|
      header
      puts question.q_text
      Answer.where(question_id: question.id).each do |answer|
        puts "#{answer.id}: #{answer.a_text}"
      end
      puts "Enter an answer's ID"
      new_answer = gets.chomp.to_i
      History.create({survey_names_id: input, question_id: question.id, answer_id: new_answer})
    end
  end
  puts "Thank you for taking the #{Survey_Name.find_by(id: input).name} survey!"
  sleep 3
end

def view_surveys
  Survey.all.each do |survey|
    puts "#{survey.id}: #{survey.name}"
  end
end

def survey_stats
  view_surveys
  puts "Enter a survey ID to view survey stats"
  input = gets.chomp.to_i
  Survey.where({survey_names_id: input}).each do |survey|
    Question.where({id: survey.question_id}).each do |question|
      puts question.q_text
      Answer.where(question_id: question.id).each do |answer|
        puts "#{answer.a_text}: #{answer.total}...percentage"
      end
    end
  end
end


main_menu
