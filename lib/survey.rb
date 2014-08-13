class Survey < ActiveRecord::Base
  has_many :questions
  has_many :survey_names
  has_many :answers, through: :questions
end
