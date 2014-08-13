class CreateSurvey < ActiveRecord::Migration
  def change
    create_table :survey_names do |t|
      t.string :name
      t.belongs_to :surveys
    end
  end
end
