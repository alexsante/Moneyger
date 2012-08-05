class ExpenseValuesController < ApplicationController
  # GET /expense_values
  # GET /expense_values.json
  def index
    @period = Period.find(params[:period_id])
    @expense = Expense.find(params[:expense_id])
    @expense_values = ExpenseValue.where("expense_date >= ? and expense_date < ? and expense_id = ?", @period.start_date, @period.end_date, params[:expense_id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # GET /expense_values/1
  # GET /expense_values/1.json
  def show
    @expense_value = ExpenseValue.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @expense_value }
    end
  end

  # GET /expense_values/new
  # GET /expense_values/new.json
  def new
    @expense_value = ExpenseValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_value }
    end
  end

  # GET /expense_values/1/edit
  def edit
    @expense_value = ExpenseValue.find(params[:id])
  end

  # POST /expense_values
  # POST /expense_values.json
  def create
    @expense_value = ExpenseValue.new(params[:expense_value])
    period = Period.find_by_date_range(@expense_value.expense_date,current_budget.id)
    
    respond_to do |format|
      if @expense_value.save
        format.html { redirect_to '/budgets', notice: 'Expense value was successfully created.' }
        format.json { 
          response = {:budget_id => period.budget_id, 
                      :period_id => period.id, 
                      :period_total => @expense_value.expense.sum_expense_values(period),
                      :expense_id => @expense_value.expense.id}
          render json: response.to_json, status: :created, location: @expense_value  
        }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expense_values/1
  # PUT /expense_values/1.json
  def update
    @expense_value = ExpenseValue.find(params[:id])

    respond_to do |format|
      if @expense_value.update_attributes(params[:expense_value])
        format.html { redirect_to @expense_value, notice: 'Expense value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_values/1
  # DELETE /expense_values/1.json
  def destroy
    @expense_value = ExpenseValue.find(params[:id])
    @expense_value.destroy

    respond_to do |format|
      format.html { redirect_to expense_values_url }
      format.json { head :no_content }
    end
  end
end
