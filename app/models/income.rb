class Income < ActiveRecord::Base

  belongs_to :budget
  has_many :income_values

  after_create :after_create

  def after_create

    new_date = Time.new

    (0..11).each do |i|

      ev = IncomeValue.new(:income_id => self.id, :amount => self.amount, :income_date => new_date)
      ev.save

      new_date = new_date.next_month

    end

  end

  def income_value_by_date(date)
    income_value = 0.00


    self.income_values.each do |iv|
      if iv.income_date.nil? == false && iv.income_date > date && iv.income_date < date + (14*24*60*60)
        income_value = iv.amount
      end
    end
    income_value
  end

end
