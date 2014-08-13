require 'active_record'
require './lib/answer'
require './lib/question'
require './lib/survey'
require './lib/history'

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
  survey = Survey.create({name: gets.chomp.capitalize})
  loop do
    puts "Enter a question type #"
    view_types
    q_type = gets.chomp.to_i
    puts "Enter survey question:"
    question_text = gets.chomp.capitalize
    new_question = survey.questions.create({q_text: question_text, q_type: q_type})
    if q_type == 3
      new_question.answers.create({a_text: "", question_id: new_question.id})
    else
      loop do
        puts "Add a potential answer to your question:"
        answer = gets.chomp.capitalize
        new_question.answers.create({a_text: answer, question_id: new_question.id})
        puts "Add another potential answer? (Y/N)"
        choice = gets.chomp.upcase
        break if choice == "N"
      end
    end
    puts "Add another question? (Y/N)"
      q_choice = gets.chomp.upcase
      break if q_choice == "N"
  end
  puts "Survey '#{survey.name}' is now available!"
end

def view_types
  puts "1 > multiple choice\n2 > multiple answers\n3 > open-ended"
end

def take_survey
  view_surveys
  puts "Enter a survey ID to take the survey"
  input = gets.chomp.to_i
  Question.where({survey_id: input}).each do |question|
    header
    puts question.q_text
    if question.q_type == 1 || question.q_type == 2
      question.answers.each do |answer|
        puts "#{answer.id}: #{answer.a_text}"
      end
      loop do
        puts "Enter an answer's ID"
        History.create({survey_id: question.survey_id, question_id: question.id, answer_id: gets.chomp.to_i})
        if question.q_type == 1
          break
        else
          puts "Would you like to enter an additonal answer (Y/N)"
          break if gets.chomp.upcase == 'N'
        end
      end
    else
      open_answer = Answer.find_by(question_id: question.id)
      open_answer.update({a_text: gets.chomp})
      History.create({survey_id: question.survey_id, question_id: question.id, answer_id: open_answer.id})
    end
  end
  puts "Thank you for taking the #{Survey.find_by(id: input).name} survey!"
  sleep 2
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
  Question.where({survey_id: input}).each do |question|
    puts question.q_text
    question.answers.each do |answer|
      puts "#{answer.a_text}: #{answer.total}...#{answer.percentage}%"
    end
    puts "\n"
  end
  gets
end


main_menu
