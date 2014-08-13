class CreateHistory < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.belongs_to :survey_names
      t.belongs_to :questions
      t.belongs_to :answers
    end
  end
end
