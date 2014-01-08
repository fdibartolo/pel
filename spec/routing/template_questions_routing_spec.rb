require "spec_helper"

describe TemplateQuestionsController do
  describe "routing" do

    it "routes to #index" do
      get("/template_questions").should route_to("template_questions#index")
    end

    it "routes to #new" do
      get("/template_questions/new").should route_to("template_questions#new")
    end

    it "routes to #show" do
      get("/template_questions/1").should route_to("template_questions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/template_questions/1/edit").should route_to("template_questions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/template_questions").should route_to("template_questions#create")
    end

    it "routes to #update" do
      put("/template_questions/1").should route_to("template_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/template_questions/1").should route_to("template_questions#destroy", :id => "1")
    end

  end
end
