class Income < ActiveRecord::Base

  belongs_to :budget
  has_many :income_values

  after_create :after_create

  def after_create

    new_date = Date.parse(self.income_date.to_s)
    prev_beginning_balance = 0

    while new_date <= Date.parse(self.income_date.to_s).end_of_year

      ev = IncomeValue.new(:income_id => self.id, :amount => self.amount, :income_date => new_date)
      ev.save
      
      # Start creating a new period
      period = Period.new
      period.start_date = new_date
      period.beginning_balance = prev_beginning_balance + self.amount
      period.budget_id = self.budget.id

      # Calculate the start of the next period
      case self.frequency
        
        when "Bi-Weekly"
          
          if new_date == new_date.end_of_month
            new_date += 15
            if new_date.wday == 6
              new_date -= 1
            elsif new_date.wday == 7
              new_date -= 2
            end 
          elsif new_date.mday == 1
            new_date += 14
          else
            new_date = new_date.end_of_month
          end
          
      end
      
      # Set the current periods end date by using the next periods start date - 1 
      period.end_date = new_date - 1
      period.save
      
      # Reset the previous beginning balance
      prev_beginning_balance = period.beginning_balance

    end

  end

  def income_value_by_date(date)
    income_value = 0.00


    self.income_values.each do |iv|
      if iv.income_date.nil? == false && iv.income_date > date && iv.income_date < date + (14*24*60*60) and !income_value.nil?
        income_value = iv.amount
      end
    end
    income_value
  end

end
