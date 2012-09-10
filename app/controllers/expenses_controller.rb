class ExpensesController < ApplicationController
  
  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show

    @budget = current_budget

    # Append budget id to the params (filtering to the current user's budget)
    params["budget_id"] = @budget.id
    @expense = Expense.find(params[:id])

    params[:pid] ||= 0

    @periods = @budget.periods.limit(17).offset(params[:pid]).order(:id).all
    @period_count = @budget.periods.count()

    respond_to do |format|
      format.html { render :layout => false}
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html {render :layout => false}
      format.js {render :layout => false}
      format.json { render :json => @expense.to_json(:include => :expense_values)}
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
    render :layout => false
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
    @expense.budget_id = session[:budget_id]

    respond_to do |format|
      if @expense.save
        format.html { redirect_to "/budgets", notice: 'Expense was successfully created.' }
        format.json { render json: @expense.to_json(:include => :expense_values), status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to '/budgets', notice: 'Expense was successfully updated.' }
        format.json { render json: @expense, status: :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    Period.recalculate_beginning_balances(budget_id= current_budget.id)

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content, status: :ok }
    end
  end
  
  def quick_update
    
    expense_value_id = params[:element_id].split("_")[2]
    expense_value = ExpenseValue.find(expense_value_id)
    expense_value.amount = params[:update_value]
    expense_value.save
    
    respond_to do |format|
        format.js { render :json => expense_value.to_json(:include => :expense) }
    end
    
  end
  
  def update_expense_values
    
    expense = Expense.find(params[:id])
    expense.update_future_values_entries(params[:date], params[:amount])
    
    respond_to do |format|
      format.js { render :json => expense.to_json(:include => :expense_values)}
    end
    
  end
  
end
