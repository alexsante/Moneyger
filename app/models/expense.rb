class Expense < ActiveRecord::Base
  has_many :expense_values, :dependent => :destroy
  belongs_to :budget

  after_create :after_create

  def after_create

    new_date = Time.new

    while new_date < Time.new.end_of_year

      ev = ExpenseValue.new(:expense_id => self.id, :amount => self.amount, :expense_date => new_date)
      ev.save

      case self.frequency

        when "Weekly"
          new_date += (7*24*60*60)
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

  def expense_value_by_date(date)
    expense_value = 0.00


    self.expense_values.each do |ev|
      if ev.expense_date.nil? == false && ev.expense_date > date && ev.expense_date < date + (14*24*60*60) and !expense_value.nil?
        expense_value = ev.amount
      end
    end
    expense_value
  end

end

