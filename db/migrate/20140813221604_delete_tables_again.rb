class DeleteTablesAgain < ActiveRecord::Migration
  def change
    drop_table :survey_names
    remove_column :surveys, :question_id, :integer
    remove_column :surveys, :survey_names_id, :integer
    remove_column :histories, :survey_names_id, :integer
    add_column :surveys, :name, :string
    add_column :questions, :survey_id, :integer
    add_column :histories, :survey_id, :integer
  end
end
