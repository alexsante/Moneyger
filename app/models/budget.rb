class Budget < ActiveRecord::Base
  has_many :expenses
  has_many :incomes
  has_many :periods

  attr_accessor :period_start_date

  after_create :after_create

  def after_create

    period_date= Date.parse(self.period_start_date)

    while period_date <= Date.new(Time.new.year,12,31)
      Period.create(:budget_id => self.id, :start_date => period_date, :end_date => period_date + 13)
      period_date +=  14
    end

  end

  def get_beginning_balance(period_start_date)
    beginning_balance = 0
  end

end
