class VariableExpense < ActiveRecord::Base
  belongs_to :expense_value
  has_many :comments, :as => :commentable

  def add_comment(comment)

    Comment.create!({:comment => comment, :commentable_type => "VariableExpense", :commentable_id => self.id})

  end

end
