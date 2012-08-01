class Budget < ActiveRecord::Base
  has_many :expenses
  has_many :incomes
  has_many :periods
  belongs_to :user

  attr_accessor :period_start_date
  after_create :after_create

  def get_beginning_balance(period_start_date)
    beginning_balance = 0
  end

  def after_create

    # Pass the budget over to the period class to generate period records for the year
    Period.generate(self)

    # TODO: Refactor this by placing it an income service (ie. create_savings_record)
    i = Income.new
    i.amount = 0
    i.frequency = "Weekly"
    i.title = "Transfer from savings"
    i.sort_weight = 100
    i.income_date = Date.tomorrow.to_s
    i.generate_periods = true
    i.budget_id = self.id
    i.save
  
    # TODO: Refactor this by placing it in an income service (ie. create_other_income)
    i = Income.new
    i.amount = 0
    i.frequency = "Weekly"
    i.title = "Other"
    i.sort_weight = 110
    i.income_date = Date.tomorrow.to_s
    i.generate_periods = true
    i.budget_id = self.id
    i.save
  
    # TODO: Refactor this by placing it in an expense service (ie. create_savings_record)  
    e = Expense.new
    e.amount = 0
    e.isfixed = false
    e.title = 'Transfer to savings'
    e.budget_id = self.id
    e.expense_date = Date.tomorrow.to_s
    e.shortcode = 'SAVE'
    e.auto_withdrawal = 0
    e.frequency = 'Weekly'
    e.save
    e.generate_expense_values
      
  end

end
