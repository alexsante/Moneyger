class Income < ActiveRecord::Base

  # Relationships
  belongs_to :budget
  has_many :income_values

  # Custom accessors
  attr_accessor :generate_periods

  # Callbacks
  after_create :after_create
  before_create :before_create
  
  # Validations
  validates :income_date, 
            :date => {:after => Date.today, :message => 'Income date must be in the future'},
            :on => :create
  
  def after_create

    # Periods are generated when the first income record is created.
    # If this flag is true, it should generate income values
    # and periods for the next 12 months
    if self.generate_periods == true

      # Date iterator helper
      date_iterator = BudgetsHelper::DateHelper.new self.income_date,self.frequency

      while date_iterator.current_date <= self.income_date.next_year

        ev = IncomeValue.new(:income_id => self.id, :amount => self.amount, :income_date => date_iterator.current_date)
        ev.save
        
        # Returns the next period date
        date_iterator.next

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
