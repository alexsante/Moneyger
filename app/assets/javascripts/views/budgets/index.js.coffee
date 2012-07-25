class Moneyger.Views.BudgetsIndex extends Backbone.View
    el: '#main_container'

    events:
      'click a#btn_new_income': 'render_incomeform'

    render_incomeform: ->
      $("#incomeModal").load '/incomes/new', ->
        $(this).modal()
      this.delegateEvents(_.extend(this.events, {"submit form#income": "create_income"}))

    create_income: ->
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