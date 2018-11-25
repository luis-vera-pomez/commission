class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :title
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
