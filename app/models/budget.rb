class Budget < ActiveRecord::Base
  has_many :expenses
  has_many :incomes
  has_many :periods

  attr_accessor :period_start_date

  def get_beginning_balance(period_start_date)
    beginning_balance = 0
  end

end
