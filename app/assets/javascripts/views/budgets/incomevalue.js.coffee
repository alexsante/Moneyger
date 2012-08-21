class Moneyger.Views.IncomeValuesIndex extends Backbone.View
    el: '.right_container'

    render_editForm: (id) ->
      $(@el).load '/income_values/'+id+'/edit', ->
        $(".right_container").animate({width: "300px"}, 350)

