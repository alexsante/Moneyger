require 'spec_helper'

describe "income_values/edit" do
  before(:each) do
    @income_value = assign(:income_value, stub_model(IncomeValue))
  end

  it "renders the edit income_value form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => income_values_path(@income_value), :method => "post" do
    end
  end
end
