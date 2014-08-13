class RenameHistoriesColumns < ActiveRecord::Migration
  def change
    rename_column :histories, :questions_id, :question_id
    rename_column :histories, :answers_id, :answer_id
  end
end
