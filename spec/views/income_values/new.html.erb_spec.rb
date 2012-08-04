require 'spec_helper'

describe "income_values/new" do
  before(:each) do
    assign(:income_value, stub_model(IncomeValue).as_new_record)
  end

  it "renders new income_value form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => income_values_path, :method => "post" do
    end
  end
end
