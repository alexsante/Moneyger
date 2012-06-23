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
            date: date,
            amount: amount
          success: (update_response) ->
            for iv in update_response.income_values
              $("#income_cell_"+iv.id).html formatCurrency iv.amount 
            # Refresh the budget
            Budget.refresh(budget_id)    
$ ->
	$(".income_cell").editInPlace
		url: '/incomes/quick_update.js'
		success: (r) -> 
      response = $.parseJSON(r)
      $(this).html(formatCurrency(response.amount))
      
      # Apply change to future entries?
      jConfirm "Would you like to apply this change to future income entries?","Confirm", (r) ->
        if r == true
          Income.update_future_entries(response.income.id, response.income_date, response.amount, response.income.budget_id);

       # Refresh the budget
      Budget.refresh(response.income.budget_id)    
   

        