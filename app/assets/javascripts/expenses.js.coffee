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
