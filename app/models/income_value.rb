class IncomeValue < ActiveRecord::Base
  # Associations
  belongs_to :income

  # Call backs
  after_create :after_create

  def after_create
    #Period.recalculate_beginning_balances(0, self.income.budget_id)
  end

end
