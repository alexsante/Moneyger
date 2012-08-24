class Moneyger.Views.IncomeValuesIndex extends Backbone.View

    render_editForm: (id) ->
      # TODO: Implement render of the popover content
      $("#income_cell_#{id}").popover 
        title: "Editing Income Value",
        placement: "bottom",
        html: true,
        trigger: "manual",
        offset: 5

      $("#income_cell_#{id}").popover("toggle")
      $(".popover-content").load("/income_values/#{id}/edit")

