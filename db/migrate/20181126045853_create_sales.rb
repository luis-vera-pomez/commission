class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :agent_id
      t.integer :product_id
      t.string :policy
      t.integer :quantity
      t.integer :total
      t.datetime :saled_at

      t.timestamp
    end
  end
end
