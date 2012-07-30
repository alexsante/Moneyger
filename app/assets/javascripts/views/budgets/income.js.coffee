class Moneyger.Views.IncomesIndex extends Backbone.View
    el: '#incomeModal'
    events: [] # Empty array place holder for delegated events

    initialize: ->
      this.unbind()

    render_newForm: ->
      parent = this
      $("#incomeModal").load '/incomes/new', ->
        $(this).modal
          shown: (e) ->
            console.log(e)
            $("#income_income_date").focus()
          hide: (e) ->
            $("#btn_save_income").undelegate()
        parent.delegateEvents(_.extend(parent.events, {"click #btn_save_income": "create"}))

    render_editForm: (id) ->
      parent = this
      $("#incomeModal").load '/incomes/'+id+'/edit', ->
        $(this).modal
          backdrop: 'static'
          title: "Edit Income"
          keyboard: true
          hide: (e) ->
            $("#btn_update_income").undelegate()
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
      this.unbind()
      this.close()


    delete: (id) ->
      income = Moneyger.mainRouter.budget.incomes.where({id: id})[0]

      $(@el).block
        message: null
      jConfirm "Are you sure you want to remove this income?","Confirm", (decision) ->
        if decision == true
          income.destroy
            url: '/incomes/'+income.get("id")
            success: (response) ->
              $("body").unblock()
              $("tr#income_row_#{id}").fadeOut().remove()
            error: (response) ->
              alert("An error occured while attempting to delete this income record.  Please try again.")
              $("body").unblock()
        else
          $("body").unblock()