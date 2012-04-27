require 'spec_helper'

describe BudgetsController do
  
  describe "GET index" do
    it "provides a loaded budget object to the view" do
      get :index
      assigns(:budget).should eq(Budget.first)
      assigns(:periods).should eq(Period.all)
    end
  end

end
