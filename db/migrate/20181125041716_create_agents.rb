class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.integer :user_id
      t.integer :team_id
      t.integer :supervised_by_id
      t.datetime :associated_at
      t.datetime :departed_at

      t.timestamps
    end
  end
end
