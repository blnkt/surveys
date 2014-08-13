class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :a_text
      t.belongs_to :answers_questions
      t.belongs_to :history
    end
  end
end
