# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @expense
  @toggle_paid = (obj) ->
    id = obj.id.split("_")[3]
    
    comment = prompt("Comments: ")

    $.ajax 
      url: "/expense_values/"+id+".json"
      type: 'PUT'
      dataType: 'json'
      data: 
        "expense_value[is_paid]": obj.checked
        "expense_value[comment]": comment
      success: (response) ->
        if obj.checked == true
          $("#expense_value_"+id).addClass("is_paid_true").removeClass("is_paid_false")
        else
          $("#expense_value_"+id).removeClass("is_paid_true").addClass("is_paid_false")

  @update_future_entries = (expense_id, date, amount, budget_id) ->
    $.ajax '/expenses/update_expense_values'
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

$ ->
  $(".expense_cell").editInPlace
    url: '/expenses/quick_update.js'
    success: (r) -> 
      response = $.parseJSON(r)
      $(this).html(formatCurrency(response.amount))
      
      # Apply change to future entries?
      jConfirm "Would you like to apply this change to future expense entries?","Confirm", (r) ->
        if r == true
          expense.update_future_entries(response.expense.id, response.expense_date, response.amount, response.expense.budget_id);
      # Refresh the budget
      Budget.refresh(response.expense.budget_id)    
