class AddPhoneNumberToProfile < ActiveRecord::Migration
  def self.up
    add_column :payment_infos, :phone, :string
  end

  def self.down
  end
end
