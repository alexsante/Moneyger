class VariableExpense < ActiveRecord::Base
  belongs_to :expense_value
  has_many :comments, :as => :commentable
end
