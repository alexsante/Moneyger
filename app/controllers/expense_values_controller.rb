class ExpenseValuesController < ApplicationController
  # GET /expense_values
  # GET /expense_values.json
  def index
    @expense_values = ExpenseValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_values }
    end
  end

  # GET /expense_values/1
  # GET /expense_values/1.json
  def show
    @expense_value = ExpenseValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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

    respond_to do |format|
      if @expense_value.save
        format.html { redirect_to @expense_value, notice: 'Expense value was successfully created.' }
        format.json { render json: @expense_value, status: :created, location: @expense_value }
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
