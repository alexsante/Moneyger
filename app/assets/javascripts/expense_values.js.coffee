# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$(".expense_value").each (e) ->
		$(this).qtip
			content: 
				text: "Loading.."
				ajax:
					url: '/expense_values'
					type: 'GET'
					data:
						expense_id: $(this).attr("expense_id")
						period_id: $(this).attr("period_id")
				title: "Variable expense entries"		
				
			show: "click"
			hide: "unfocus"
			position:  
				my: 'bottom center'
				at: 'top center'
				target: 'event'
				adjust:
					y: -25
			style:
				classes: 'ui-tooltip-wiki ui-tooltip-light ui-tooltip-shadow'
				
@create_expense = (event) ->
	# Responds to "ENTER" and "TAB"
	if event.keyCode == 13 || event.keyCode == 9

		# Create the new expense value
		response = $.ajax '/expense_values.json', 
			type: 'POST'
			dataType: 'JSON'
			data: 
				'expense_value[amount]': $("#expense_amount").val()
				'expense_value[expense_id]': $("#expense_id").val()
				'expense_value[comment]': $("#expense_comment").val()
				'expense_value[expense_date]': $("#expense_date").val()
			success: (data) ->
				console.log(data)
				# Build a new table body row
				content = "<tr>";
				content += "<td>" + $("#expense_date").val() + "</td>";
				content += "<td>" + formatCurrency($("#expense_amount").val()) + "</td>";
				content += "<td>" + $("#expense_comment").val() + "</td>";
				content += "</tr>"

				# Append it
				$("table#expense_values tbody").append(content);

				# Clear field values in preparation for next entry
				$("#expense_amount").val("").focus();
				$("#expense_comment").val("");
				
				# Update the budget
				Budget.refresh data.budget_id

				$("#expense_value_"+data.expense_id+"_"+data.period_id+" span").html(formatCurrency(data.period_total))
