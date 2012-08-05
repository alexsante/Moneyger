require 'spec_helper'

describe "variable_expenses/index" do
  before(:each) do
    assign(:variable_expenses, [
      stub_model(VariableExpense,
        :amount => "9.99",
        :expense_id => ""
      ),
      stub_model(VariableExpense,
        :amount => "9.99",
        :expense_id => ""
      )
    ])
  end

  it "renders a list of variable_expenses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
