class Moneyger.Views.IncomeValuesIndex extends Backbone.View

    initialize: (options) ->
      @collection = options.collection

    render_editForm: (id) ->
      # Remove existing popovers
      $(".popover").each( -> $(this).remove() )

      # Renders the edit form and creates a popover on success.
      # Response html is loaded into the popover via the target
      # elements "data-content" attribute
      $.get "/income_values/#{id}/edit", null, (r) ->

        # Set the data-content attribute that bootstrap popover uses for content
        $("#income_cell_#{id}").attr("data-content",r)

        # Create the popover
        $("#income_cell_#{id}").popover
          title: "Editing Income",
          placement: "bottom",
          html: true,
          trigger: "manual",
          offset: 5

        # Toggle the display
        $("#income_cell_#{id}").popover("toggle")

    create_comment: (event) ->
      comment = $(event.target).val()
      id = $(event.target).attr("commentable_id")
      $.post "/income_values/#{id}/comment",
        comment: comment,
        success: (r) ->
          #TODO: Create a template for this
          div = document.createElement("div")
          $(div).addClass("comment")

          c = document.createElement("quote")
          c.appendChild(document.createTextNode(comment))
          div.appendChild(c)

          # Add it to the UI
          $("#iv_comments").append(div)
          $(event.target).val("")

    update: (event) ->
      id = Number($(event.currentTarget).attr("incomevalue_id"))
      income_id = Number($(event.currentTarget).attr("income_id"))
      amount = $("#income_value_amount").val()
      income_date = $(event.currentTarget).attr("income_date")

      income = @collection.where({id: income_id})[0]
      income_value = income.incomeValues.where({id: id})[0]
      income_value.set("amount", amount)
      income_value.save(null, {url: "income_values/#{id}"})

      if $("#apply_future").attr("checked") is "checked"
        Income.update_future_entries(income_id, income_date, amount)
