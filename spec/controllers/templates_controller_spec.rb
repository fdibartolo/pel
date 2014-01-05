require 'spec_helper'

describe TemplatesController do
  it "should return the dashboard template" do
    get 'template', { path: 'dashboard' }
    response.should be_success
    response.should render_template 'dashboard'
  end
end
