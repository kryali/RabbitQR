class CreatePaymentInfos < ActiveRecord::Migration
  def self.up
    create_table :payment_infos do |t|
      t.string :cardnumber
      t.string :csv
      t.string :exp
      t.string :address
      t.string :city
      t.string :state
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_infos
  end
end
