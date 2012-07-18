# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @Expense
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

  @new = ->
     $("#expenseModal").modal();
     $("#expenseModal").load('/expenses/new.js');

  @destroy = (id) ->
    $("body").block
      message: null
    jConfirm "Are you sure you want to remove this expense?","Confirm", (decision) ->
      if decision == true
        $.post '/expenses/'+id+'.json',
          _method: 'delete'
        (r) ->
          $("tr#expense_row_"+id).fadeOut().remove()
      $("body").unblock()

  @save = (id) ->
    if id == undefined
      method = 'POST'
      url = '/expenses.json'
      action = 'create'
    else
      method = 'PUT'
      url = '/expenses/'+id+'.json'
      action = 'update'

    formData = $("form#expense").serialize()

    $.ajax
      type: method
      url: url
      data: formData
      success: (r) ->
        if action == 'update'
          $("tr#expense_row_"+r.id+" span.expense_title").html(r.title)
          $("#expenseModall").toggleClass('in')
          $("div.modal-backdrop").remove()
        else if action == 'create'
          Expense.render(r)
          $("#expenseModal").modal("hide")
      error: (r) ->
        $("form#expense").unblock()
        errors = $.parseJSON(r.responseText)
        $("div#notice").html("").addClass("alert alert-error")
        $("div#notice").append("<h4>Please check your form</h4><ul></ul>")
        for e of errors
          for ve in errors[e]
            $("div#notice ul").append("<li>"+e+": "+ve+"</li>")

  # Renders a single expense record across the budget table
  @render = (e) ->
    $.get '/expenses/'+e.id, {isfixed: e.isfixed, auto_withdrawal: e.auto_withdrawal}, (response) ->
      if e.isfixed == false
        $("tbody.variable_expenses").append(response)
      else
        if e.auto_withdrawal
          $("tbody.fixed_expenses_aw").append(response)
        else
          $("tbody.fixed_expenses").append(response)

      # Reinitialize qtip edit boxes
      Expense_Value.initialize_qtip()

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
