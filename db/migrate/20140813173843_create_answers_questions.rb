class CreateAnswersQuestions < ActiveRecord::Migration
  def change
    create_table :answers_questions do |t|
      t.belongs_to :questions
      t.belongs_to :answers
    end
  end
end
