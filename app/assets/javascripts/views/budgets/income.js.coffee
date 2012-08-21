class Moneyger.Views.IncomesIndex extends Backbone.View
    el: '#incomeModal'

    initialize: (options) ->
      @collection = options.collection

    render_newForm: ->
      parent = this
      $("#incomeModal").load '/incomes/new', ->
        $(this).modal
          shown: (e) ->
            $("#income_income_date").focus()

    render_editForm: (id) ->
      parent = this
      $("#incomeModal").load '/incomes/'+id+'/edit', ->
        $(this).modal
          backdrop: 'static'
          title: "Edit Income"

    update: (event) ->
      $.ajax '/incomes/'+$(event.currentTarget).attr("income_id")+'.json',
        type: "PUT"
        data: $("form#income").serialize()
        success: (response) ->
          $("#income_title_#{response.id}").html(response.title).effect("highlight",6000)
          $("#incomeModal").modal("hide")

    create: ->
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

    delete: (id) ->
      # Load income model
      income = @collection.where({id: id})[0]
      # Localize the collection variable for use later
      collection = @collection

      # Block the UI
      $(@el).block
        message: null

      # Render confirmation message
      jConfirm "Are you sure you want to remove this income?","Confirm", (decision) ->
        if decision == true
          income.destroy
            url: '/incomes/'+income.get("id")
            success: (response) ->
              $("body").unblock()
              $("tr#income_row_#{id}").fadeOut().remove()
              collection.remove(income)
            error: (response) ->
              alert("An error occured while attempting to delete this income record.  Please try again.")
              $("body").unblock()
        else
          $("body").unblock()