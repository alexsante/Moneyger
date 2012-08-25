class Moneyger.Views.IncomeValuesIndex extends Backbone.View

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
