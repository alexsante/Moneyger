class Moneyger.Views.ExpenseView extends Backbone.View

    initialize: (options) ->

        @collection = options.collection
        @collection.bind "reset", @renderAll, this
        @collection.bind "remove", @renderTotal, this

    renderAll: (eventName) ->

        _.each @collection.models, ((expense) ->
          $(@el).prepend new Moneyger.Views.ExpenseTileView(model: expense).render().el
        ), this
        
        $("#expense_tiles_container").prepend @el
        
        # Render the period total
        @renderTotal()

    renderOne: (model) ->

        $(@el).prepend new Moneyger.Views.ExpenseTileView(model: model).render().el
        
        $("#expense_tiles_container").prepend @el

        # Render the period total
        @renderTotal()

    renderTotal: ->

        # Reset the period total to zero.  It will be recalculated below
        period_total = 0

        # Loops over the collection while adding to the period total
        _.each @collection.models, ((expense) ->
          period_total += Number(expense.toJSON().amount)  if expense.toJSON().amount > 0
        ), this

        # Renders the income total for the period
        $("#expense_period_total").html formatCurrency(period_total)

    renderNewExpense: ->
        $("#expenseModal").load '/expenses/new', -> 
            $("#expenseModal").modal()

    renderEditExpense: (id) ->
        $("#expenseModal").load '/expenses/'+id+'/edit', ->
            $("#expenseModal").modal() 

    createExpense: ->
        view = this

        formPayload = $("#expense").serializeObject()
        expense = new Moneyger.Models.Expense
        expense.save formPayload,
            success: (model, response, options) ->
                view.renderOne(model)
                view.collection.add(model)
                $("#expenseModal").modal("hide")

    removeExpense: (id, event) ->
      # Load income model
      expense = @collection.get(id)
      # Localize the collection variable for use later
      collection = @collection
      # Block the UI
      $(@el).block
        message: null

      # Render confirmation message
      jConfirm "Are you sure you want to remove this expense?","Confirm", (decision) ->
        if decision == true
          expense.destroy
            url: '/expenses/'+id
            success: (response) ->
              $("body").unblock()
              $("#expense_#{id}").fadeOut().remove()
              collection.remove(expense)
              return true
            error: (response) ->
              alert("An error occured while attempting to delete this expense record.  Please try again.")
              $("body").unblock()
              return false
        else
          $("body").unblock()
          return false                


class Moneyger.Views.ExpenseTileView extends Backbone.View
    
    template: _.template($("#expense_tile_template").html())
    
    events:
        "dblclick": "flip"
        "click .icon-trash": "remove"

    render: (eventName) ->
        $(@el).html @template(@model.toJSON())
        this  

    flip: (event) ->
        $(@el).children(".tile").toggleClass("flip")
 
    remove: (event) ->
        if App.expense_view.removeExpense($(event.currentTarget).attr("expense_id"), event) == true
            $(@el).remove()        