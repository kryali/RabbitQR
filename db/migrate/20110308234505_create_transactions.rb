class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :payer_id
      t.integer :receiver_id
      t.float :amount
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
