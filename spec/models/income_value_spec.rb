require 'spec_helper'

describe IncomeValue do

  it "should create a new comment associated to the income value" do

    # create a new income value
    iv = IncomeValue.first
    iv.add_comment "This is a test comment for income value #{iv.id}"
    iv.comments.length.should == 1
    iv.comments.first.comment.should == "This is a test comment for income value #{iv.id}"

  end

end
