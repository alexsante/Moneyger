class Moneyger.Views.IncomeView extends Backbone.View

    initialize: ->
        @model.bind "reset", @render, this

    render: (eventName) ->
        period_total = 0
        _.each @model.models, ((income) ->
          $(@el).append new Moneyger.Views.IncomeTileView(model: income).render().el
          
          # Adds up the total income amounts for the period
          period_total += Number(income.toJSON().amount)  if income.toJSON().amount > 0
        ), this
        
        # Add a div to clear out the floats
        $(@el).append "<div style='clear: both'></div>"
        $("#income_tiles_container").html @el
        
        # Renders the income total for the period
        $("#income_period_total").html formatCurrency(period_total)

class Moneyger.Views.IncomeTileView extends Backbone.View
    
    template: _.template($("#income_tile_template").html())

    render: (eventName) ->
        $(@el).html @template(@model.toJSON())
        this