require 'spec_helper'

describe TemplatesController do
  %w[
    dashboard
    new
    new_request
    inbox
    errors
  ].each do |template|
    it "should return the #{template} template" do
      get 'template', { path: template }
      response.should be_success
      response.should render_template template
    end
  end
end
