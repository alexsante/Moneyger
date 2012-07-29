class Moneyger.Views.BaseView extends Backbone.View
    close: ->
      this.remove()
      this.unbind()