class DeleteStuff < ActiveRecord::Migration
  def change
    remove_column :questions, :answers_questions_id, :integer
    remove_column :questions, :history_id, :integer
    remove_column :answers, :answers_questions_id, :integer
    remove_column :answers, :history_id, :integer
    remove_column :survey_names, :surveys_id, :integer
  end
end
