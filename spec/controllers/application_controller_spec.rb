require 'spec_helper'

describe ApplicationController do
  it "should return success (to be called by CI box to check app running)" do
    get :health
    response.should be_success
  end
end
