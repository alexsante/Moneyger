# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @Income
  @update_future_entries = (income_id, date, amount, budget_id) ->
    $.ajax '/incomes/update_income_values'
          type: 'POST'
          dataType: 'JSON'
          data: 
            id: income_id
            date: date
            amount: amount
          success: (update_response) ->
            for iv in update_response.income_values
              income = Moneyger.mainRouter.budget.incomes.where({id: income_id})[0]
              incomevalue = income.incomeValues.where({id: iv.id})[0]
              incomevalue.set("amount", iv.amount)
            # Refresh the budget
            Moneyger.recalculate_periods()

