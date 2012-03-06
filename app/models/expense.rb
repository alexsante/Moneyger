class Expense < ActiveRecord::Base
  has_many :expense_values
  belongs_to :budget

  after_create :after_create

  def after_create

    ev = ExpenseValue.new(:expense_id => self.id, :amount => self.amount, :expense_date => self.expense_date)
    ev.save

  end

  def expense_value_by_date(date)
    expense_value = 0.00

    self.expense_values.each do |ev|
      if ev.expense_date > date && ev.expense_date < date + (14*24*60*60)
        expense_value = ev.amount
      end
    end
    expense_value
  end

end

