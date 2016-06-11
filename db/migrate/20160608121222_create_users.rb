class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.belongs_to :team
      t.string :first_name
      t.string :last_name
      t.string :token
    end
  end

  def down
    drop_table :users
  end

end