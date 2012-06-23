# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @Budget
	
	@refresh = (budget_id) ->
		$.ajax '/fetch_periods/'+budget_id+'.json',
			type: 'GET'
			dataType: 'JSON'
			success: (r) ->
				for period in r
					$("tr#starting_balance td#balance_"+period.period_id).html(formatCurrency period.beginning_balance)
					$("td#income_total_"+period.period_id).html(formatCurrency period.income_total)
					$("#remaining_balance_"+period.period_id).html(formatCurrency period.ending_balance)