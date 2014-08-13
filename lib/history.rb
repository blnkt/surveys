class History < ActiveRecord::Base
  has_many :survey_names
  has_many :questions
  has_many :answers
end
