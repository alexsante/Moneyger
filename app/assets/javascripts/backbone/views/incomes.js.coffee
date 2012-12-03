class Moneyger.Views.IncomeView extends Backbone.View

    initialize: ->

        @model.bind "reset", @renderAll, this

    renderAll: (event) ->

        _.each @model.models, ((income) ->
          $(@el).prepend new Moneyger.Views.IncomeTileView(model: income).render().el
        ), this
        
        $("#income_tiles_container").prepend @el
        
        # Render the period total
        @renderTotal()

    renderOne: (model) ->

        new Moneyger.Views.IncomeTileView(model: income).render().el
        # Render the period total
        @renderTotal()

    renderTotal: ->

        # Reset the period total to zero.  It will be recalculated below
        period_total = 0

        # Loops over the collection while adding to the period total
        _.each @model.models, ((income) ->
          period_total += Number(income.toJSON().amount)  if income.toJSON().amount > 0
        ), this

        # Renders the income total for the period
        $("#income_period_total").html formatCurrency(period_total)

    renderNewIncome: ->
        $("#incomeModal").load '/incomes/new', -> 
            $("#incomeModal").modal()

    renderEditIncome: (id) ->



class Moneyger.Views.IncomeTileView extends Backbone.View
    
    template: _.template($("#income_tile_template").html())

    events:
        "click": "flip"

    render: (event) ->
        $(@el).html @template(@model.toJSON())
        this

    flip: (event) ->
        $(@el).children(".tile").toggleClass("flip")
