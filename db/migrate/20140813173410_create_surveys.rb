class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.belongs_to :answers_questions
      t.belongs_to :survey_names
    end
  end
end
