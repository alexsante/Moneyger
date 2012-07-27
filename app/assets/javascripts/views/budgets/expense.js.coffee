class Moneyger.Views.ExpenseIndex extends Backbone.View
    el: '#main_container'

    events:
      'click a.btn_new_expense': 'render_newForm'
      'click a.btn_edit_expense': 'render_editForm'
      'click a.btn_delete_expense': 'delete'

    render_newForm: (event) ->
      parent = this
      eventType = $(event.currentTarget).attr("type")
      $("#expenseModal").load '/expenses/new', ->
        $(this).modal()
        # Modify the form depending on the type of event that was clicked
        if eventType is "fixed"
          $("#expense_isfixed").val(1)
          expensetoggle(1)
          $("#expense_auto_withdrawal").attr("checked", false)
        else if eventType == "fixed_aw"
          $("#expense_isfixed").val(1)
          expensetoggle(1)
          $("#expense_auto_withdrawal").attr("checked", true)
        else
          $("#expense_isfixed").val(0)
          $("#expense_auto_withdrawal").attr("checked", false)
          expensetoggle(0)
        parent.delegateEvents(_.extend(parent.events, {"click #btn_save_expense": "create"}))

    render_editForm: (event) ->
      parent = this
      id = $(event.currentTarget).attr("expense_id")
      $("#expenseModal").load '/expenses/'+id+'/edit', ->
        $(this).modal
          keyboard: false
          backdrop: 'static'
          title: "Edit Expense"
          keyboard: true
        parent.delegateEvents(_.extend(parent.events, {"click #btn_update_expense": "update"}))

    update: (event) ->
      $.ajax '/expenses/'+$(event.currentTarget).attr("expense_id")+'.json',
        type: "PUT"
        data: $("form#expense").serialize()
        success: (response) ->
          $("#expense_title_#{response.id}").html(response.title).effect("highlight",6000)
          $("#expenseModal").modal("hide")

    create: ->
      @collection = new Moneyger.Collections.Expenses
      @collection.create({
        amount: $("#expense_amount").val()
        expense_date: $("#expense_expense_date").val()
        frequency: $("#expense_frequency").val()
        title: $("#expense_title").val(),
        isfixed: $("#expense_isfixed").val(),
        auto_withdrawal: $("#expense_autowithdrawal").val()},
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

    delete: (event) ->
      expenses = new Moneyger.Collections.Expenses
      expense.where({id: event.expense_id})
      #$(@el).block
      #  message: null
