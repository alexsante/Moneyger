class Moneyger.Views.IncomeView extends Backbone.View

    period_total_el: $("#income_period_total")

    initialize: ->

        @collection.bind "reset", @renderAll, this
        @collection.bind "add", @renderAll, this
        @collection.bind "remove", @renderTotal, this

    renderAll: (event) ->

        _.each @collection.models, ((income) ->
          $(@el).prepend new Moneyger.Views.IncomeTileView(model: income).render().el
        ), this

        $("#income_tiles_container").prepend @el

        # Render the period total
        @renderTotal()

    renderOne: (model) =>

        $(@el).prepend new Moneyger.Views.IncomeTileView(model: model).render().el

        $("#income_tiles_container").prepend @el

        # Render the period total
        @renderTotal()

    renderTotal: ->

        # Reset the period total to zero.  It will be recalculated below
        period_total = 0

        # Loops over the collection while adding to the period total
        _.each @collection.models, ((income) ->
          period_total += Number(income.toJSON().amount)  if income.toJSON().amount > 0
        ), this

        # Renders the income total for the period
        $(@period_total_el).html formatCurrency(period_total)

    renderNewIncome: ->
        $("#incomeModal").load '/incomes/new', -> 
            $("#incomeModal").modal()

    renderEditIncome: (id) ->
        $("#incomeModal").load '/incomes/'+id+'/edit', ->
            $("#incomeModal").modal()

    createIncome: ->
        view = this

        formPayload = $("#income").serializeObject()
        income = new Moneyger.Models.Income 
        income.save formPayload, 
            success: (model, response, options) ->
                view.renderOne(model)
                @models.add(model)
                $("#incomeModal").modal("hide")

    removeIncome: (id, event) ->
      # Load income model
      income = @collection.get(id)
      # Localize the collection variable for use later
      collection = @collection
      # Block the UI
      $(@el).block
        message: null

      # Render confirmation message
      jConfirm "Are you sure you want to remove this income?","Confirm", (decision) ->
        if decision == true
          income.destroy
            url: '/incomes/'+id
            success: (response) ->
              $("body").unblock()
              $("#income_#{id}").fadeOut().remove()
              collection.remove(income)
            error: (response) ->
              alert("An error occured while attempting to delete this income record.  Please try again.")
              $("body").unblock()
          return true
        else
          $("body").unblock()
          return false

class Moneyger.Views.IncomeTileView extends Backbone.View
    
    template: _.template($("#income_tile_template").html())

    events:
        "dblclick": "flip"
        "click .icon-trash": "remove"

    render: (event) ->
        $(@el).html @template(@model.toJSON())
        this

    flip: (event) ->
        $(@el).children(".tile").toggleClass("flip")

    remove: (event) ->
        if App.income_view.removeIncome($(event.currentTarget).attr("income_id"), event) == true
            $(@el).remove()

