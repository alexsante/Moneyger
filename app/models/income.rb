class Income < ActiveRecord::Base

  belongs_to :budget
  has_many :income_values

  attr_accessor :generate_periods

  after_create :after_create
  before_create :before_create
  
  def after_create

    if self.generate_periods == true

      new_date = BudgetsHelper::DateHelper.new self.income_date,self.frequency

      while new_date.current_date <= self.income_date.next_year

        ev = IncomeValue.new(:income_id => self.id, :amount => self.amount, :income_date => new_date.current_date)
        ev.save
        
        new_date.next

      end

      # Generate the periods
      Period.generate(self)
      # Recalculate period balances
      Period.recalculate_beginning_balances(budget_id = self.budget_id)

    end

  end

  def before_create
    
    # If no sort weight is provided, default to zero
    self.sort_weight = 0 if self.sort_weight == "" || self.sort_weight.nil? 
    
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
