require 'active_record'
require 'rspec'
require 'answer'
require 'question'
require 'survey'
require 'history'
require 'survey_name'
require 'answers_questions'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)
