class Moneyger.Models.IncomeValue extends Backbone.Model
  url: '/income_values'

  initialize: ->
    this.bind("change", this.handleOnChange, this)

  handleOnChange: (model, event) ->
    $("#income_cell_#{model.get('id')}").html(formatCurrency(model.get("amount")))
