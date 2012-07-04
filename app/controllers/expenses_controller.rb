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
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.js {render :layout => false}
      format.json { render :json => @expense.to_json(:include => :expense_values)}
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
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
        format.json { head :no_content }
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

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
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
