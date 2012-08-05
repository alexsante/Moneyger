require "spec_helper"

describe VariableExpensesController do
  describe "routing" do

    it "routes to #index" do
      get("/variable_expenses").should route_to("variable_expenses#index")
    end

    it "routes to #new" do
      get("/variable_expenses/new").should route_to("variable_expenses#new")
    end

    it "routes to #show" do
      get("/variable_expenses/1").should route_to("variable_expenses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/variable_expenses/1/edit").should route_to("variable_expenses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/variable_expenses").should route_to("variable_expenses#create")
    end

    it "routes to #update" do
      put("/variable_expenses/1").should route_to("variable_expenses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/variable_expenses/1").should route_to("variable_expenses#destroy", :id => "1")
    end

  end
end
