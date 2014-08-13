class Survey < ActiveRecord::Base
  has_many :answers_questions
  has_many :survey_names
end
