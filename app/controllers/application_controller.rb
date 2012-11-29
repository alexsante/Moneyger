class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  private

  def layout_by_resource

    if devise_controller?
      "login"
    else
      "tiles"
    end

  end

  def current_budget

    if session.has_key? "budget_id"
      budget = Budget.find(session[:budget_id])
    else
      budget = Budget.find_or_create_by_user_id(current_user.id, :title => "My Budget", :beginning_balance => 0)
      session[:budget_id] = budget.id
    end

    budget

    rescue ActiveRecord::RecordNotFound
      budget = Budget.new
      budget.period_start_date= Time.now
      budget.beginning_balance= 0
      budget.title="My Budget"
      budget.user_id = current_user.id
      budget.save
      session[:budget_id] = budget.id
      budget
  end

  def set_current_budget(budget_id)
    budget = Budget.find(budget_id)
    session[:budget_id] = budget.id
    budget
  end

end
