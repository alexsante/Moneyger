class Expense < ActiveRecord::Base
  has_many :expense_values, :dependent => :destroy
  belongs_to :budget

  after_create :generate_expense_values
  after_update :generate_expense_values

  validates :title, :amount, :budget_id, :presence => true
  validates_presence_of :expense_date, :if => :isfixed?

  def generate_expense_values

    ExpenseValue.delete_all(["expense_id = :expense_id", {:expense_id => self.id}])

    # Date iterator helper
    date_iterator = BudgetsHelper::DateHelper.new self.expense_date,self.frequency

    new_date = Date.parse(self.expense_date.to_s)

    while date_iterator.current_date <= self.expense_date.next_year

      ev = ExpenseValue.new(:expense_id => self.id, :amount => self.amount, :expense_date => date_iterator.current_date)
      ev.save

      # Returns the next period date
      date_iterator.next
  

    end
    
    Period.recalculate_beginning_balances(budget_id = self.budget_id)

  end

  def expense_value_by_date(date)
    expense_value = 0.00


    self.expense_values.each do |ev|
      if ev.expense_date.nil? == false && ev.expense_date > date && ev.expense_date < date + (14*24*60*60) and !expense_value.nil?
        expense_value = ev.amount
      end
    end
    expense_value
  end
  
  def expense_value_by_period(period)
    
    expense_value = ExpenseValue.new(:amount => 0)
    
    self.expense_values.each do |ev|
      
      if ev.expense_date.nil? == false && ev.expense_date >= period.start_date && ev.expense_date <= period.end_date
        expense_value = ev
      end
      
    end
    
    expense_value
  end
  
  def sum_expense_values(period)

      ExpenseValue.joins(:expense).sum(:amount, :conditions => ["expense_values.expense_date >= ? and
                                                       expense_values.expense_date <= ? and
                                                       expenses.budget_id = ?",
                                                       period.start_date,
                                                       period.end_date,
                                                       period.budget_id]).to_f

  end
  
  # Will update the value of all expense value entries going forward.
  def update_future_values_entries(date,amount)
    ExpenseValue.update_all({:amount => amount},["expense_date >= ? AND expense_id = ?", date, self.id])
    # Recalculate period balances
    Period.recalculate_beginning_balances(budget_id = self.budget_id)
  end

end

