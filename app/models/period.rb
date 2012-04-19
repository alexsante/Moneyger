class Period < ActiveRecord::Base
  belongs_to :budget

  attr_accessor :fixed_expense_total
  attr_accessor :variable_expense_total
  attr_accessor :income_total

  def find_income_value(income)

    # Returns all income values logged into this period and budget
    income_value = IncomeValue.where("income_id = ? and income_date >= ? and income_date <= ?", income.id, self.start_date, self.end_date).first

  end

  def find_expense_values(expense)
    # Returns all expense values logged into this period and budget
    ExpenseValue.sum(:amount, :conditions => ["expense_id = ? and expense_date >= ? and expense_date <= ?", expense.id, self.start_date, self.end_date])
  end
  
  def fixed_expense_total(auto_withdrawal = 0)
    ExpenseValue.joins(:expense).sum(:amount, :conditions => ["isfixed = TRUE and expense_values.expense_date >= ? and expense_values.expense_date <= ? and budget_id = ? and auto_withdrawal = ?", 
                                                                      self.start_date, self.end_date, self.budget_id, auto_withdrawal])
  end
  
  def variable_expense_total
    ExpenseValue.joins(:expense).sum(:amount, :conditions => ["isfixed = false AND expense_values.expense_date >= ? and expense_values.expense_date <= ? and budget_id = ?", 
                                                              self.start_date, self.end_date, self.budget_id])
  end

  def income_total
    IncomeValue.joins(:income).sum(:amount, :conditions => ["income_values.income_date >= ? and income_values.income_date <= ?", self.start_date, self.end_date])
  end
  
  def ending_balance
    self.beginning_balance + income_total - fixed_expense_total - fixed_expense_total(1) - variable_expense_total
  end
  
  def self.recalculate_beginning_balances(period_id, budget_id)
    # Recalculates the beginning balance of a every period in the budget starting from period passed in
    periods = Period.where("id >= ? and budget_id = ?", period_id, budget_id)
    
    (1...periods.length).each do |i|
      periods.at(i).update_attributes(:beginning_balance => periods.at(i-1).ending_balance)  
    end
    
  end

end
