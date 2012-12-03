class Moneyger.Views.ExpenseView extends Backbone.View

    initialize: ->

        @model.bind "reset", @renderAll, this

    renderAll: (eventName) ->

        _.each @model.models, ((expense) ->
          $(@el).prepend new Moneyger.Views.ExpenseTileView(model: expense).render().el
        ), this
        
        $("#expense_tiles_container").prepend @el
        
        # Render the period total
        @renderTotal()

    renderOne: (model) ->

        new Moneyger.Views.ExpenseTileView(model: expense).render().el
        # Render the period total
        @renderTotal()

    renderTotal: ->

        # Reset the period total to zero.  It will be recalculated below
        period_total = 0

        # Loops over the collection while adding to the period total
        _.each @model.models, ((expense) ->
          period_total += Number(expense.toJSON().amount)  if expense.toJSON().amount > 0
        ), this

        # Renders the income total for the period
        $("#expense_period_total").html formatCurrency(period_total)

        

class Moneyger.Views.ExpenseTileView extends Backbone.View
    
    template: _.template($("#expense_tile_template").html())
    
    events:
        "click": "flip"

    render: (eventName) ->
        $(@el).html @template(@model.toJSON())
        this  

    flip: (event) ->
        $(@el).children(".tile").toggleClass("flip")          