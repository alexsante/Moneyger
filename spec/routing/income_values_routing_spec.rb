require "spec_helper"

describe IncomeValuesController do
  describe "routing" do

    it "routes to #index" do
      get("/income_values").should route_to("income_values#index")
    end

    it "routes to #new" do
      get("/income_values/new").should route_to("income_values#new")
    end

    it "routes to #show" do
      get("/income_values/1").should route_to("income_values#show", :id => "1")
    end

    it "routes to #edit" do
      get("/income_values/1/edit").should route_to("income_values#edit", :id => "1")
    end

    it "routes to #create" do
      post("/income_values").should route_to("income_values#create")
    end

    it "routes to #update" do
      put("/income_values/1").should route_to("income_values#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/income_values/1").should route_to("income_values#destroy", :id => "1")
    end

  end
end
