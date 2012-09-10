# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @Expense

  @update_future_entries = (expense_id, date, amount, budget_id) ->
    $.ajax
          url: '/expenses/update_expense_values'
          type: 'POST'
          dataType: 'JSON'
          data: 
            id: expense_id
            date: date,
            amount: amount
          success: (update_response) ->
            for ev in update_response.expense_values
              $("#expense_cell_"+ev.id).html formatCurrency ev.amount 
            # Refresh the budget
            Budget.refresh(budget_id)    
