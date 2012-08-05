class IncomeValue < ActiveRecord::Base
  # Associations
  belongs_to :income
  has_many :comments, :as => :commentable

  def add_comment(comment)

    Comment.create!({:comment => comment, :commentable_type => "IncomeValue", :commentable_id => self.id})

  end

end
