class Expense < ActiveRecord::Base
  has_many :expense_values, :dependent => :destroy
  belongs_to :budget

  after_create :generate_expense_values, :after_create
  after_update :generate_expense_values

  def after_create
    Period.recalculate_beginning_balances(budget_id = self.budget_id)
  end

  def generate_expense_values

    # Clear out existing values if the type is fixed
    if self.isfixed
      
      ExpenseValue.delete_all(["expense_id = :expense_id", {:expense_id => self.id}])

      new_date = Date.parse(self.expense_date.to_s)
  
      while new_date <= Date.parse(self.expense_date.to_s).end_of_year
  
        ev = ExpenseValue.new(:expense_id => self.id, :amount => self.amount, :expense_date => new_date)
        ev.save
  
        case self.frequency
  
          when "Weekly"
            new_date = new_date.next_week
          when "Bi-Weekly"
            new_date += (14*24*60*60)
          when "Monthly"
            new_date = new_date.next_month
          when "Bi-Monthly"
            new_date = new_date.next_month
            new_date = new_date.next_month
        end
  
      end
      
    end

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
  
  def sum_expense_values(period)

      ExpenseValue.joins(:expense).sum(:amount, :conditions => ["expense_values.expense_date >= ? and
                                                       expense_values.expense_date <= ? and
                                                       expenses.budget_id = ?",
                                                       period.start_date,
                                                       period.end_date,
                                                       period.budget_id]).to_f

  end

end

