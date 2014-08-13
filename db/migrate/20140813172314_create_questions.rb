class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_text
      t.belongs_to :answers_questions
      t.belongs_to :history
    end
  end
end
