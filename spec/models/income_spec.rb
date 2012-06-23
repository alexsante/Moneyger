require 'spec_helper'

describe Income do
  
  before(:all) do 
    @budget = Budget.new(:title => "Test Budget", :beginning_balance => 100)
    @budget.save
  end
  
  before(:each) do
    @income = Income.new
  end
  
  it "should generate 12 periods if the generate flag is active after create" do
  
    # Confirm the number of periods is starting at zero
    Period.where(:budget_id => @budget.id).count.should == 0
    
    # Create a new income record with the generate periods flag active
    income = Income.new
    income.title= "Test income title"
    income.income_date = Date.today + 1
    income.amount = 100
    income.frequency = "Bi-Weekly"
    income.budget_id = @budget.id
    income.generate_periods = true
    income.save.should == true
    
    # Confirm the number of periods generated is no longer zero
    Period.where(:budget_id => @budget.id).count.should > 0
    
  end
  
  it "should set it's own sort weight to zero if none is provided" do
    
    # Create a new income record with the generate periods flag active
    income = Income.new
    income.title= "Test income title"
    income.income_date = Date.today + 1
    income.amount = 100
    income.frequency = "Bi-Weekly"
    income.budget_id = @budget.id
    income.generate_periods = true
    income.save.should == true
    
    # Sort weight should have defaulted to zero because we did not provide a weight
    income.sort_weight.should == 0
    
  end
  
  it "should create a new income record, but not generate periods" do
    
    # Confirm the number of periods is starting at zero
    Period.where(:budget_id => @budget.id).count.should == 0
    
    # Create a new income record with the generate periods flag active
    income = Income.new
    income.title= "Test income title"
    income.income_date = Date.today + 1
    income.amount = 100
    income.frequency = "Bi-Weekly"
    income.budget_id = @budget.id
    income.generate_periods = false
    income.save.should == true
    
    # Confirm the number of periods generated is still zero
    Period.where(:budget_id => @budget.id).count.should == 0
    
  end
  
  it "should fail validation if the income date is not in the future" do
    
     # Create a new income record with the generate periods flag active
    income = Income.new
    income.title= "Test income title"
    income.income_date = "2012-01-01"
    income.amount = 100
    income.frequency = "Bi-Weekly"
    income.budget_id = @budget.id
    income.generate_periods = true

    # Object should have failed validation and not have saved
    income.save.should == false
    income.valid?.should == false
    
    # Check the error message returned
    income.errors[:income_date][0].should == "Income date must be in the future"
    
    
  end
  
  it "should update all values for income value entries past the given date" do
    
    # Confirm the number of periods is starting at zero
    Period.where(:budget_id => @budget.id).count.should == 0
    
    # Create a new income record with the generate periods flag active
    income = Income.new
    income.title= "Test income title"
    income.income_date = Date.today + 1
    income.amount = 100
    income.frequency = "Bi-Weekly"
    income.budget_id = @budget.id
    income.generate_periods = true
    income.save.should == true
    
    # Confirm the number of periods generated is no longer zero
    Period.where(:budget_id => @budget.id).count.should > 0
    
    # Confirm all income value entries are for $100 dollars
    income.income_values.each do |iv|
      iv.amount.should == 100
    end
    
    # Now update all income values going forward to $200 dollars
    iv = income.income_values.first
    income.update_future_values_entries(iv.income_date,200)
    
    # Confirm all income value entries are for $200 dollars
    IncomeValue.where(:income_id => income.id).each do |iv|
      iv.amount.to_i.should == 200
    end
    
  end
  
end
