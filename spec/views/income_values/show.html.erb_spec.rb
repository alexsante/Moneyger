require 'spec_helper'

describe "income_values/show" do
  before(:each) do
    @income_value = assign(:income_value, stub_model(IncomeValue))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
