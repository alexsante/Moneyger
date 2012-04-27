require 'spec_helper'

describe Expense do
  
  fixtures :all

  before(:each) do
    @expense = Expense.first
  end

  it "should return the sum of all expense values for a period" do
    @expense.sum_expense_values(period_id = 1000).should == 100.00
  end

  it "should set that status of an expense value to paid" do
    @expense.paid(expense_value_id).should == true
  end

  it "should set the status of a paid expense to pending" do
    @expense.pending(expense_value_id).should == true
  end

end
