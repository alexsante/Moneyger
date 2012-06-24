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

  @edit = (id) ->
    $("#incomeModal").modal
      keyboard: false, 
      backdrop: 'static', 
      title: "Edit Income"
      
    $("#incomeModal").load('/incomes/'+id+'/edit')       
    
  @new = ->
    $("#incomeModal").modal 
      title: 'New Income'
    $("#incomeModal").load('/incomes/new.js')
    
  @save = () ->
    
    $("form#new_income").block
      message: "<div class='hero-unit'><h3>Please hold</h3><p>One second while we process your request.</p></div>"
      css: 
        width: 500
    
    formData = $("form#new_income").serialize()
      
    $.ajax
      type: 'POST' 
      url: '/incomes.js' 
      data: formData
      success: (r) ->
        location.href='/'
      error: (r) ->
        $("form#new_income").unblock()
        errors = $.parseJSON(r.responseText)
        $("div#notice").html("").addClass("alert alert-error")
        $("div#notice").append("<h4>Please check your form</h4><ul></ul>")
        for e of errors
          for ve in errors[e]
            $("div#notice ul").append("<li>"+e+": "+ve+"</li>")
        
    return false 
                
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
      
   
   

        