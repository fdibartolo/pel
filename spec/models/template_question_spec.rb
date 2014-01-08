require 'spec_helper'

describe TemplateQuestion do
  it "must have a body" do
    template_question = FactoryGirl.build :template_question, body: nil
    template_question.valid?.should be_false
    template_question.errors.count.should == 1
    template_question.errors[:body].should include "can't be blank"
  end
end
