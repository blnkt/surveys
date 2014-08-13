class Answer < ActiveRecord::Base
  belongs_to :answers_questions
  belongs_to :history
end
