# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class @Expense_Value

  @initialize_qtip = ->
    $(".expense_value").each (e) ->
      $(this).qtip
        content:
          text: "Loading.."
          ajax:
            url: '/expense_values/'+$(this).attr("expense_value_id")
            type: 'GET'
          title: "Variable expense entries"
        show: "click"
        hide: "unfocus"
        position:
          my: 'left center'
          at: 'right center'
          target: 'event'
        style:
          classes: 'ui-tooltip-wiki ui-tooltip-light ui-tooltip-shadow'
        events:
          render: (event, api) ->
            # Event for closing the tip window when the escape key is pressed
            $(window).bind "keydown", (e) ->
              if e.keyCode == 27
                api.hide(e)


  @create_expense = (event) ->
    # Responds to "ENTER" and "TAB"
    if event.keyCode == 13 || event.keyCode == 9

      # Create the new expense value
      response = $.ajax '/variable_expenses.json',
        type: 'POST'
        dataType: 'JSON'
        data:
          'variable_expense[amount]': Number($("#expense_amount").val())
          'variable_expense[expense_value_id]': $("#expense_value_id").val()
          'comment': $("#expense_comment").val()
          'variable_expense[expense_date]': $("#expense_date").val()
        success: (data) ->
          # Grab the expense value from the collection
          ev = Moneyger.mainRouter.budget.expenses.get(data.expense_value.expense_id).expenseValues.get(data.expense_value_id)

          # Build a new variable expense
          ve = new Moneyger.Models.VariableExpense()
          ve.set("amount", data.amount)
          ve.set("expense_date", data.expense_date)
          ve.set("id", data.id)
          ve.set("updated_at", data.updated_at)
          ve.set("expense_value_id", data.expense_value_id)

          # Add to the collection
          ev.variable_expenses.add(ve, {silent: true})

          # Build a new table body row
          content = "<tr>";
          content += "<td>" + $("#expense_date").val() + "</td>";
          content += "<td>" + formatCurrency($("#expense_amount").val()) + "</td>";
          content += "<td>" + $("#expense_comment").val() + "</td>";
          content += "</tr>"

          # Append it
          $("table#expense_values tbody").append(content);

          # Animate progress bar.  Find the new consumed percentage (cp)
          # TODO: This functionality needs to be refactored and made reusable
          # ***********************************************************#
          cp = (Number(ev.variable_expense_total()) / Number(ev.get("amount"))) * 100
          if cp >= 75 && cp < 100
            $(".expense_value[expense_value_id=#{ev.id}] div.progress").removeClass("progress-success progress-striped").addClass("progress-warning")
          else if cp >= 100
            $(".expense_value[expense_value_id=#{ev.id}] div.progress").removeClass("progress-success progress-warning").addClass("progress-danger progress-striped active")
          $(".expense_value[expense_value_id=#{ev.id}] div.bar").animate({width: "#{cp}%"})
          # ************************************************************#

          # Clear field values in preparation for next entry
          $("#expense_amount").val("").focus();
          $("#expense_comment").val("");
          $(".expense_value[expense_value_id=#{ev.id}] span").html(formatCurrency(ev.variable_expense_total()))