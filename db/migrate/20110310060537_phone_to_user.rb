class PhoneToUser < ActiveRecord::Migration
  def self.up
    remove_column :payment_infos, :phone
    add_column :users, :phone, :string
  end

  def self.down
  end
end
