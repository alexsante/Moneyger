class IncomeValuesController < ApplicationController
  # GET /income_values
  # GET /income_values.json
  def index
    @income_values = IncomeValue.first

    respond_to do |format|
      format.html { render layout: false}# index.html.erb
      format.json { render json: @income_values }
    end
  end

  # GET /income_values/1
  # GET /income_values/1.json
  def show
    @income_value = IncomeValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @income_value }
    end
  end

  # GET /income_values/new
  # GET /income_values/new.json
  def new
    @income_value = IncomeValue.new

    respond_to do |format|
      format.html
      format.json { render json: @income_value }
    end
  end

  # GET /income_values/1/edit
  def edit
    @income_value = IncomeValue.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false}
    end
  end

  # POST /income_values
  # POST /income_values.json
  def create
    @income_value = IncomeValue.new(params[:income_value])

    respond_to do |format|
      if @income_value.save
        format.html { redirect_to @income_value, notice: 'Income value was successfully created.' }
        format.json { render json: @income_value, status: :created, location: @income_value }
      else
        format.html { render action: "new" }
        format.json { render json: @income_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /income_values/1
  # PUT /income_values/1.json
  def update
    @income_value = IncomeValue.find(params[:id])

    respond_to do |format|
      if @income_value.update_attributes(params[:income_value])
        format.html { redirect_to @income_value, notice: 'Income value was successfully updated.' }
        format.json { render json: @income_value }
      else
        format.html { render action: "edit" }
        format.json { render json: @income_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /income_values/1
  # DELETE /income_values/1.json
  def destroy
    @income_value = IncomeValue.find(params[:id])
    @income_value.destroy

    respond_to do |format|
      format.html { redirect_to income_values_url }
      format.json { head :no_content }
    end
  end

  def comment

    income_value = IncomeValue.find(params[:id])
    income_value.add_comment(params[:comment])

    respond_to do |format|
      format.json {head :no_content}
    end

  end
end
