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

    it "should not be able to manage personal engagement lists that he doesnt own" do
      @ability.should_not be_able_to(:manage, PersonalEngagementList.new(user_id: @user.id + 1))
    end
  end

  describe "Administrator" do
    before :each do
      @user.roles << FactoryGirl.build(:role, name: AdminRole)
      @ability = Ability.new(@user)
    end

    it "should be able to manage template questions" do
      @ability.should be_able_to(:manage, TemplateQuestion.new)
    end

    it "should be able to manage personal engagement lists" do
      @ability.should be_able_to(:manage, PersonalEngagementList.new)
    end
  end
end
