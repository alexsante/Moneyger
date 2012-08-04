require 'spec_helper'

describe "income_values/index" do
  before(:each) do
    assign(:income_values, [
      stub_model(IncomeValue),
      stub_model(IncomeValue)
    ])
  end

  it "renders a list of income_values" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
