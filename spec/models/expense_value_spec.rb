require 'spec_helper'

describe ExpenseValue do
  fixtures :all

  it "should contain variable expense records" do

    ev = ExpenseValue.first
    ev.variable_expenses.length.should == 2

  end


end