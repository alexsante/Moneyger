class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  validates :comment, :presence => true
end
