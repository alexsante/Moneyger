class Moneyger.Views.ExpenseIndex extends Backbone.View
    el: '#main_container'
    events: [] # Empty array place holder for delegated events

    render_newForm: (type) =>
      parent = this
      console.log(this)
      $("#expenseModal").load '/expenses/new', ->
        $(this).modal()
        # Modify the form depending on the type of event that was clicked
        if type is "fixed"
          $("#expense_isfixed").val(1)
          $("#expense_auto_withdrawal").attr("checked", false)
        else if type == "fixed_aw"
          $("#expense_isfixed").val(1)
          $("#expense_auto_withdrawal").attr("checked", true)
        else
          $("#expense_isfixed").val(0)
          $("#expense_auto_withdrawal").attr("checked", false)

    render_editForm: (id) ->
      parent = this
      $("#expenseModal").load '/expenses/'+id+'/edit', ->
        $(this).modal
          backdrop: 'static'
          title: "Edit Expense"
          keyboard: true
    update: (id) ->
      $.ajax '/expenses/'+id+'.json',
        type: "PUT"
        data: $("form#expense").serialize()
        success: (response) ->
          $("#expense_title_#{response.id}").html(response.title).effect("highlight",6000)
          $("#expenseModal").modal("hide")

    create: ->
      @collection = Moneyger.mainRouter.budget.expenses
      @collection.create({
        amount: $("#expense_amount").val()
        expense_date: $("#expense_expense_date").val()
        frequency: $("#expense_frequency").val()
        title: $("#expense_title").val(),
        isfixed: $("#expense_isfixed").val(),
        auto_withdrawal: $("#expense_auto_withdrawal").val()},
        wait: true
        success: (model, response) ->
          # Render the expense record
          $.get '/expenses/'+model.id, (getResponse) ->
            console.log(model)
            if model.get("isfixed") is true
              if model.get("auto_withdrawal")? and model.get("auto_withdrawal") is true
                $("tbody.fixed_expenses_aw").prepend(getResponse)
              else
                $("tbody.fixed_expenses").prepend(getResponse)
            else
              $("tbody.variable_expenses").prepend(getResponse)

            # Reinitialize qtip edit boxes
            Expense_Value.initialize_qtip()
            # Hide the popup modal
            $("#expenseModal").modal("hide")
      )

    delete: (id) ->
      expense = Moneyger.mainRouter.budget.expenses.where({id: id})[0]

      $(@el).block
        message: null
      jConfirm "Are you sure you want to remove this expense?","Confirm", (decision) ->
        if decision == true
          expense.destroy
            url: '/expenses/'+expense.get("id")
            success: (response) ->
              $("tr#expense_row_#{expense.get('id')}").fadeOut().remove()
              $("body").unblock()
            error: (response) ->
              alert("An error occured while attempting to delete this expense record.  Please try again.")
              $("body").unblock()
        else
          $("body").unblock()
