class CreateTeamsTable < ActiveRecord::Migration

  def up
    create_table :teams do |t|
      t.string :name
      t.datetime :program_starts_at
    end
  end

  def down
    drop_table :teams
  end

end
