class RefactorEverything < ActiveRecord::Migration
  def change
    add_column :answers, :question_id, :integer
    drop_table :answers_questions
    remove_column :surveys, :answers_questions_id, :integer
    add_column :surveys, :question_id, :integer
  end
end
