class History < ActiveRecord::Base
  has_many :surveys
  has_many :questions
  has_many :answers
end
