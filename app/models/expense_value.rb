class ExpenseValue < ActiveRecord::Base
  belongs_to :expense
  
  def self.find_all_by_period(period_id, expense_id)
    
    period = Period.find(period_id)
    
    ExpenseValue.where("expense_date >= :start_date AND expense_date <= :end_date AND expense_id = :expense_id", 
    {:start_date => period.start_date, :end_date => period.end_date, :expense_id => expense_id})
    
  end
  
  
end
