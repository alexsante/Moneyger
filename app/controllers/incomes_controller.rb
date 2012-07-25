class IncomesController < ApplicationController
  # GET /incomes
  # GET /incomes.json
  def index
    @incomes = Income.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incomes }
    end
  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show

    @budget = current_budget
    @income = Income.find(params[:id])
   
    # Append budget id to the params (filtering to the current user's budget)
    params["budget_id"] = @budget.id
    params[:pid] ||= 0

    @periods = @budget.periods.limit(10).offset(params[:pid]).order(:id).all
    @period_count = @budget.periods.count()

    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @income }
    end
  end

  # GET /incomes/new
  # GET /incomes/new.json
  def new
    @income = Income.new

    respond_to do |format|
      format.html { render :layout => false } 
      format.js { render :layout => false }     
      format.json { render json: @income }
    end
  end

  # GET /incomes/1/edit
  def edit
    @income = Income.find(params[:id])
    render :layout => false
  end

  # POST /incomes
  # POST /incomes.json
  def create

    @income = Income.new(params[:income])
    @income.budget = current_budget
    @income.generate_periods = true

    if @income.save
      render :json => @income.to_json(:include => :income_values), status: :created, location: @income
    else
      render json: @income.errors, status: :unprocessable_entity 
    end

  end

  # PUT /incomes/1
  # PUT /incomes/1.json
  def update
    @income = Income.find(params[:id])

    respond_to do |format|
      if @income.update_attributes(params[:income])
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
        format.json { render json: @income, status: :created }
      else
        format.html { render action: "edit" }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def quick_update
    
    if params[:element_id] == 'undefined'
      income_value = IncomeValue.new
      income_value.amount = params[:update_value]
      income_value.income_id = params[:income_id]
      income_value.income_date = Date.parse(params[:date])
      income_value.save
    else  
      income_value_id = params[:element_id].split("_")[2]
      income_value = IncomeValue.find(income_value_id)
      income_value.amount = params[:update_value]
      income_value.save
    end  
    
    # Trigger a period refresh
    Period.recalculate_beginning_balances(0,current_budget.id)
    respond_to do |format|
        format.js { render :json => income_value.to_json(:include => :income) }
    end
    
  end
  
  def update_income_values
    
    income = Income.find(params[:id])
    income.update_future_values_entries(params[:date], params[:amount])
    
    respond_to do |format|
      format.js { render :json => income.to_json(:include => :income_values)}
    end
    
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    respond_to do |format|
      format.html { redirect_to incomes_url }
      format.json { head :no_content }
    end
  end
end
