require 'spec_helper'

describe "variable_expenses/show" do
  before(:each) do
    @variable_expense = assign(:variable_expense, stub_model(VariableExpense,
      :amount => "9.99",
      :expense_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    rendered.should match(//)
  end
end
