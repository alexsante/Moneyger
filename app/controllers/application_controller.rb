class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_budget
    if session.has_key? "budget_id"
      budget = Budget.find(session[:budget_id])
    else
      budget = Budget.first_or_create
      session[:budget_id] = budget.id
    end

    budget
  rescue ActiveRecord::RecordNotFound
    budget = Budget.create
    session[:budget_id] = budget.id
    budget
  end

  def set_current_budget(budget_id)
    budget = Budget.find(budget_id)
    session[:budget_id] = budget.id
    budget
  end

end
