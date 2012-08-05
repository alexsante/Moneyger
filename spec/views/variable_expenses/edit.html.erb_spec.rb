require 'spec_helper'

describe "variable_expenses/edit" do
  before(:each) do
    @variable_expense = assign(:variable_expense, stub_model(VariableExpense,
      :amount => "9.99",
      :expense_id => ""
    ))
  end

  it "renders the edit variable_expense form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => variable_expenses_path(@variable_expense), :method => "post" do
      assert_select "input#variable_expense_amount", :name => "variable_expense[amount]"
      assert_select "input#variable_expense_expense_id", :name => "variable_expense[expense_id]"
    end
  end
end
