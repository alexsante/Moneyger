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
    
    # TODO: Refactor this by placing it an income service (ie. create_savings_record)
    i = Income.new
    i.amount = 0
    i.frequency = "Monthly"
    i.title = "Transfer from savings"
    i.sort_weight = 100
    i.income_date = Time.now
    i.generate_periods = false
    i.budget_id = self.id
    i.save
  
    # TODO: Refactor this by placing it in an income service (ie. create_other_income)
    i = Income.new
    i.amount = 0
    i.frequency = "Bi-Weekly"
    i.title = "Other"
    i.sort_weight = 110
    i.income_date = Time.now
    i.generate_periods = false
    i.budget_id = self.id
    i.save
  
    # TODO: Refactor this by placing it in an expense service (ie. create_savings_record)  
    e = Expense.new
    e.amount = 0
    e.isfixed = false
    e.title = 'Transfer to savings'
    e.budget_id = self.id
    e.expense_date = Time.now
    e.shortcode = 'SAVE'
    e.auto_withdrawal = 0
    e.frequency = 'Bi-Weekly'
    e.save
      
  end

end
