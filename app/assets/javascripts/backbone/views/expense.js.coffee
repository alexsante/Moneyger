class Moneyger.Views.ExpenseView extends Backbone.View

    initialize: ->
        @model.bind "reset", @render, this

    render: (eventName) ->
        period_total = 0
        _.each @model.models, ((Expense) ->
          $(@el).append new Moneyger.Views.ExpenseTileView(model: Expense).render().el
          
          # Adds up the total Expense amounts for the period
          period_total += Number(Expense.toJSON().amount)  if Expense.toJSON().amount > 0
        ), this
        
        # Add a div to clear out the floats
        $(@el).append "<div style='clear: both'></div>"
        $("#expense_tiles_container").html @el
        
        # Renders the Expense total for the period
        $("#expense_period_total").html formatCurrency(period_total)

class Moneyger.Views.ExpenseTileView extends Backbone.View
    
    template: _.template($("#expense_tile_template").html())

    render: (eventName) ->
        $(@el).html @template(@model.toJSON())
        this