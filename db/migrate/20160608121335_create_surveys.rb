class CreateSurveys < ActiveRecord::Migration

  def up
    create_table :survey_definitions do |t|
      t.string :name
      t.integer :week_indices, array: true, default: []
      t.integer :lateness_allowed
      t.json :format
      t.timestamps
    end

    create_table :survey_obligations do |t|
      t.belongs_to :user
      t.belongs_to :survey_definition
      t.datetime :due_at
      t.datetime :expires_at
      t.datetime :submitted_at
      t.json :submission
      t.timestamps
    end
  end

  def down
    drop_table :survey_definitions
    drop_table :survey_obligations
  end

end