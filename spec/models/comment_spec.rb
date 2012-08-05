require 'spec_helper'

describe Comment do

  it "should validate presence of comment" do

    c = Comment.new
    c.should_not be_valid

    c.comment= "Test"
    c.should be_valid

  end


end
