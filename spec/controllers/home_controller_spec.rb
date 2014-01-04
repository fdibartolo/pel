require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', nil, { user_id: 1 }
      response.should be_success
    end
  end
end
