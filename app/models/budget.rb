class Budget < ActiveRecord::Base
  has_many :expenses
  has_many :incomes
  has_many :periods

  attr_accessor :period_start_date
  after_create :create_savings_account

  def get_beginning_balance(period_start_date)
    beginning_balance = 0
  end

  def create_savings_account
    
    i = Income.new
    i.amount = 0
    i.frequency = "Monthly"
    i.title = "Transfer from savings"
    i.sort_weight = 100
    i.income_date = Date.parse(Time.now.to_s)
    i.generate_periods = false
    i.save
      
  end

end
