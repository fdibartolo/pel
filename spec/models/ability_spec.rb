require 'spec_helper'
require "cancan/matchers"

describe "Ability" do
  before :each do
    @user = FactoryGirl.create :user
  end

  describe "Regular user (everyone)" do
    before :each do
      @ability = Ability.new(@user)
    end

    it "should be able to manage personal engagement lists that he owns" do
      @ability.should be_able_to(:manage, PersonalEngagementList.new(user_id: @user.id))
    end

    describe "should not be able to manage" do
      {
        "personal engagement lists that he doesnt own" => "PersonalEngagementList.new(user_id: @user.id + 1)",
        "template questions" => "TemplateQuestion.new",
        "requests" => "Request.new"
      }.each do |title, model|
        it title do
          @ability.should_not be_able_to(:manage, eval(model))
        end
      end
    end
  end

  describe "Requestor" do
    before :each do
      @user.roles << FactoryGirl.build(:role, name: RequestorRole)
      @ability = Ability.new(@user)
    end

    it "should be able to manage requests that he owns" do
      @ability.should be_able_to(:manage, Request.new(owner_id: @user.id))
    end

    describe "should not be able to manage" do
      {
        "requests that he doesnt own" => "Request.new(owner_id: @user.id + 1)",
        "template questions" => "TemplateQuestion.new"
      }.each do |title, model|
        it title do
          @ability.should_not be_able_to(:manage, eval(model))
        end
      end
    end
  end

  describe "Administrator" do
    before :each do
      @user.roles << FactoryGirl.build(:role, name: AdminRole)
      @ability = Ability.new(@user)
    end

    describe "should be able to manage" do
      {
        "template questions" => "TemplateQuestion.new",
        "personal engagement lists" => "PersonalEngagementList.new",
        "requests" => "Request.new"
      }.each do |title, model|
        it title do
          @ability.should be_able_to(:manage, eval(model))
        end
      end 
    end
  end
end
