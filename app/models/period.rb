class Period < ActiveRecord::Base
  belongs_to :budget

  attr_accessor :fixed_expense_total
  attr_accessor :variable_expense_total
  attr_accessor :income_total
  after_initialize :after_initialize

  def after_initialize
    @expense_total = 0
    @income_total = 0
    @variable_expense_total = 0
  end

  def find_income_value(income)

    # Returns all income values logged into this period and budget
    income_value = IncomeValue.where("income_id = ? and income_date >= ? and income_date <= ?", income.id, self.start_date, self.end_date)

    if income_value.length == 0
      0
    else
      income_value.first.amount
    end

  end

  def find_expense_values(expense)
    # Returns all expense values logged into this period and budget
    ExpenseValue.sum(:amount, :conditions => ["expense_id = ? and expense_date >= ? and expense_date <= ?", expense.id, self.start_date, self.end_date])
  end

end
