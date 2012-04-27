require 'spec_helper'

describe Period do
  fixtures :periods, :expense_values, :expenses, :incomes, :income_values
  
  it "should sum up fixed expenses in the period" do
    period = Period.first
    period.fixed_expense_total.to_i.should eq 100
  end
  
  it "should sum up variable expenses in a period" do
    period = Period.first
    period.variable_expense_total.to_i.should eq 500
  end
  
  it "should sum up income values in the period" do
    period = Period.first
    period.income_total.to_i.should eq 10
  end
  
  it "should have a beginning balance of 9.99" do
    period = Period.first
    period.beginning_balance.should eq 9.99
  end

end
