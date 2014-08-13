class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :surveys
  belongs_to :histories
end
