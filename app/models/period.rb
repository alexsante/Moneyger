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
    ev = ExpenseValue.joins(:expense).select("SUM(expense_values.amount) as expense_value_total").where(
                                              "expenses.id = :expense_id 
                                              AND expense_values.expense_date >= :start_date 
                                              AND expense_values.expense_date < :end_date", 
                                              :expense_id => expense.id,:start_date => self.start_date,:end_date => self.end_date).first
    if expense.isfixed == false
      ev.expense_value_total.to_i > 0 ? ev.expense_value_total.to_i : expense.amount.to_i
    else
      ev.expense_value_total.to_i > 0 ? ev.expense_value_total.to_i : 0.00
    end

  end

  def fixed_expense_total(auto_withdrawal = 0)
    ExpenseValue.joins(:expense).sum(:amount, :conditions => ["isfixed = TRUE 
                                                               and expense_values.expense_date >= ? 
                                                               and expense_values.expense_date <= ? 
                                                               and budget_id = ? 
                                                               and auto_withdrawal = ?", 
                                                               self.start_date, self.end_date, self.budget_id, auto_withdrawal])
  end
  
  def variable_expense_total

    # Keeps track of a running total
    total = 0
    
    Expense.where(:budget_id => self.budget_id, :isfixed => false).each do |expense|
     total += self.find_expense_values(expense) 
    end
    
    total
  end

  def income_total

    IncomeValue.joins(:income).sum(:amount, :conditions => ["income_values.income_date >= ? 
                                                            and income_values.income_date <= ? 
                                                            and incomes.budget_id = ?",
                                                            self.start_date, self.end_date, self.budget_id])

  end
  
  def ending_balance

    # TODO: Optimize this line of code so it doesn't have to hit the DB 4 times
    self.beginning_balance + income_total - fixed_expense_total - fixed_expense_total(1) - variable_expense_total

  end

  def self.recalculate_beginning_balances(period_id=0, budget_id)

    Thread.new do
      begin
        # Recalculates the beginning balance of a every period in the budget starting from period passed in
        periods = Period.where("id >= ? and budget_id = ?", period_id, budget_id).order(:id)
        
        periods.each_with_index do |p,i|
          if i > 0
            p.update_attributes(:beginning_balance => periods[i-1].ending_balance)
          end
        end
      end
    end 
  end
  
  def self.periods_to_json(budget_id, offset)
    
    @response = []
    
    Period.where(:budget_id => budget_id).limit(10).offset(offset).order(:id).each do |period|
      
      @response << {:id => period.id,
                    :start_date => period.start_date,
                    :end_date => period.end_date,
                    :beginning_balance => period.beginning_balance, 
                    :fixed_expense_total => period.fixed_expense_total, 
                    :fixed_aw_expense_total => period.fixed_expense_total(1),
                    :variable_expense_total => period.variable_expense_total,
                    :income_total => period.income_total,
                    :ending_balance => period.ending_balance}
      
    end
    
    @response
  end

  def self.find_by_date_range(date,budget_id)
    # Returns a single budget active record based on the date and budget id
    # passed in. 
    Period.where("budget_id = :budget_id AND start_date <= :date and end_date >= :date", :budget_id => budget_id, :date => date).first
  end
  
  def self.generate(budget)
  
    # This method is executed after a nwe budget is created and will create
    # period records for up to a year after the budget start date.

    # Keep track of the running date
    new_date = BudgetsHelper::DateHelper.new(budget.created_at,"Weekly")

    while new_date.current_date < budget.created_at.next_year
      
      period = Period.new(:start_date => new_date.current_date, 
                          :budget_id => budget.id,
                          :beginning_balance => budget.beginning_balance)

      new_date.next

      # Sets the current periods end date by using the next period's start date
      # minus one
      period.end_date = new_date.current_date - 1
      period.save

    end
      
    Period.count
  end

end  
