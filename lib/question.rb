class Answer < ActiveRecord::Base
  belongs_to :history
  belongs_to :question
end
