class BudgetsController < ApplicationController

  before_filter :authenticate_user!

  def set
    set_current_budget params[:budget_id]
    respond_to do |format|
      format.html { redirect_to '/budgets'}
    end
  end

  # GET /budgets
  # GET /budgets.json
  def index
    @budget = current_budget
    @user = current_user

    params[:pid] ||= 0

    @periods = @budget.periods.limit(17).offset(params[:pid]).order(:id).all
    @period_count = @budget.periods.count()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @budget.to_json(
            :include => [
                # Includes income records and their associated income value records
                { :incomes => {:include => :income_values} },
                # Includes expense records, their associated income value records, and variable expenses (if any)
                { :expenses => {:include => {:expense_values => {:include => :variable_expenses}} }}
            ])
      }
    end
  end

  # GET /budgets/new
  # GET /budgets/new.json
  def new
    @budget = Budget.new
    @user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budget }
    end
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(params[:budget])
    @budget.user_id= current_user.id

    respond_to do |format|
      if @budget.save
        set_current_budget @budget.id
        format.html { redirect_to '/' }
        format.json { render json: @budget, status: :created, location: @budget }
      else
        format.html { render action: "new" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /budgets/1
  # PUT /budgets/1.json
  def update
    @budget = Budget.find(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :no_content }
    end
  end
  
  def periods

      params[:pid] ||= 0
      @budget = current_budget
      Period.recalculate_beginning_balances(period_id = 0, budget_id = @budget.id)
      @periods = Period.periods_to_json(current_budget.id, params[:pid])

      respond_to do |format|
        format.json { render json: @periods }
      end

  end
    
    
end
