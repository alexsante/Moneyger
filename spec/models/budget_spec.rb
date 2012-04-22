require 'spec_helper'

describe Budget do
  fixtures :all
  
  before(:each) do
    @budget = Budget.new
  end
  
  it "should create a savings income record automatically" do

    @budget.title = 'Unit Test'
    @budget.beginning_balance = 0
    @budget.save.should == true
    Income.where(:budget_id => @budget.id, :title => 'Transfer from savings').count.should == 1
    
  end
  
  it "should create an 'other' income record automatically" do
    
    @budget.title = "Test Spec"
    @budget.beginning_balance = 0
    @budget.save.should == true
    Income.where(:budget_id => @budget.id, :title => 'Other').count.should == 1
    
  end
  
  it "should create a savings expense record automatically" do
    
    @budget.title = 'Unit Test'
    @budget.beginning_balance = 0
    @budget.save.should == true
    Expense.where(:budget_id => @budget.id, :title => 'Transfer to savings').count.should == 1
    
  end 
  
  
end
