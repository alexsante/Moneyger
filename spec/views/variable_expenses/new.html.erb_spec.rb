require 'spec_helper'

describe "variable_expenses/new" do
  before(:each) do
    assign(:variable_expense, stub_model(VariableExpense,
      :amount => "9.99",
      :expense_id => ""
    ).as_new_record)
  end

  it "renders new variable_expense form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => variable_expenses_path, :method => "post" do
      assert_select "input#variable_expense_amount", :name => "variable_expense[amount]"
      assert_select "input#variable_expense_expense_id", :name => "variable_expense[expense_id]"
    end
  end
end
