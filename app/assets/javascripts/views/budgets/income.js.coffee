class Moneyger.Views.IncomesIndex extends Backbone.View
    el: '#main_container'

    events:
      'click a#btn_new_income': 'render_newForm'
      'click a#btn_edit_income': 'render_editForm'

    render_newForm: ->
      parent = this
      $("#incomeModal").load '/incomes/new', ->
        $(this).modal()
        parent.delegateEvents(_.extend(parent.events, {"click #btn_save_income": "create"}))

    render_editForm: (event) ->
      parent = this
      id = $(event.currentTarget).attr("income_id")
      $("#incomeModal").load '/incomes/'+id+'/edit', ->
        $(this).modal
          keyboard: false
          backdrop: 'static'
          title: "Edit Income"
          keyboard: true
        parent.delegateEvents(_.extend(parent.events, {"click #btn_update_income": "update"}))

    update: (event) ->
      $.ajax '/incomes/'+$(event.currentTarget).attr("income_id")+'.json',
        type: "PUT"
        data: $("form#income").serialize()
        success: (response) ->
          $("#income_title_#{response.id}").html(response.title).effect("highlight",6000)
          $("#incomeModal").modal("hide")

    create: ->
      @collection = new Moneyger.Collections.Incomes()
      @collection.create({
        amount: $("#income_amount").val()
        income_date: $("#income_income_date").val()
        frequency: $("#income_frequency").val()
        title: $("#income_title").val()},
        wait: true
        success: (model, response) ->
          # Render the income record
          $.get '/incomes/'+model.id, (getResponse) ->
            $("tbody.incomes").prepend(getResponse)

            # Reinitialize qtip edit boxes
            Expense_Value.initialize_qtip()
            # Hide the popup modal
            $("#incomeModal").modal("hide")
      )