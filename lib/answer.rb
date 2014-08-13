class Question < ActiveRecord::Base
  belongs_to :answers_questions
  belongs_to :histories
end
