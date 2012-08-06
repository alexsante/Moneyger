class VariableExpensesController < ApplicationController
  # GET /variable_expenses
  # GET /variable_expenses.json
  def index
    @variable_expenses = VariableExpense.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @variable_expenses }
    end
  end

  # GET /variable_expenses/1
  # GET /variable_expenses/1.json
  def show
    @variable_expense = VariableExpense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @variable_expense }
    end
  end

  # GET /variable_expenses/new
  # GET /variable_expenses/new.json
  def new
    @variable_expense = VariableExpense.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @variable_expense }
    end
  end

  # GET /variable_expenses/1/edit
  def edit
    @variable_expense = VariableExpense.find(params[:id])
  end

  # POST /variable_expenses
  # POST /variable_expenses.json
  def create
    @variable_expense = VariableExpense.new(params[:variable_expense])

    respond_to do |format|
      if @variable_expense.save
        # Add comment
        @variable_expense.add_comment(params[:comment]) if params[:comment].to_s.length > 0
        # Render
        format.html { redirect_to @variable_expense, notice: 'Variable expense was successfully created.' }
        format.json { render json: @variable_expense, status: :created, location: @variable_expense }
      else
        format.html { render action: "new" }
        format.json { render json: @variable_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /variable_expenses/1
  # PUT /variable_expenses/1.json
  def update
    @variable_expense = VariableExpense.find(params[:id])

    respond_to do |format|
      if @variable_expense.update_attributes(params[:variable_expense])
        format.html { redirect_to @variable_expense, notice: 'Variable expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @variable_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variable_expenses/1
  # DELETE /variable_expenses/1.json
  def destroy
    @variable_expense = VariableExpense.find(params[:id])
    @variable_expense.destroy

    respond_to do |format|
      format.html { redirect_to variable_expenses_url }
      format.json { head :no_content }
    end
  end
end
