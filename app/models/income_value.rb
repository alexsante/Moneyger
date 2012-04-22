class IncomeValue < ActiveRecord::Base

  belongs_to :income
  after_save :after_save
  
  def after_save
    Period.recalculate_beginning_balances(0, self.income.budget_id) 
  end

end