class Budget < ActiveRecord::Base
  has_many :expenses
end
