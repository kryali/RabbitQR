class User < ActiveRecord::Base

has_many :payment_infos
has_many :transactions

end
