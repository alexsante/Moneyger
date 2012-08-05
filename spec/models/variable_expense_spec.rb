require 'spec_helper'

describe VariableExpense do

  it "should create a comment associated to the expense value" do

    ev = VaribleExpense.first
    ev.add_comment "This is a test comment for variable expense #{ev.id}"
    ev.comments.length.should == 1
    ev.comments.first.comment.should == "This is a test comment for variable expense #{ev.id}"

  end

end
