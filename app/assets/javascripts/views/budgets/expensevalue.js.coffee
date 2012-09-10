class Moneyger.Views.ExpenseValuesIndex extends Backbone.View

  initialize: (options) ->
    @collection = options.collection

  render_editForm: (id) ->
    # Remove exisitng popovers
    Moneyger.clear_popovers()

    $.get "/expense_values/#{id}/edit", null, (r) ->

      # Set the data-content attributes that bootstrap uses for the popover plugin
      $("#expense_cell_#{id}").attr("data-content", r)

      # Create the popover
      $("#expense_cell_#{id}").popover
        title: "Editing Expense",
        placement: "bottom",
        html: true,
        trigger: "manual",
        offset: 5

      # Display the popover
      $("#expense_cell_#{id}").popover("toggle")

  create_comment: (event) ->
    comment = $(event.target).val()
    id = $(event.target).attr("commentable_id")

    $.post "/expense_values/#{id}/comment",
      comment: comment,
      success: (r) ->
        #TODO: Create a template for this
        div = document.createElement("div")
        $(div).addClass("comment")

        c = document.createElement("quote")
        c.appendChild(document.createTextNode(comment))
        div.appendChild(c)

        # Add it to the UI
        $("#ev_comments").append(div)
        $(event.target).val("")

  update: (event) ->
    id = Number($(event.currentTarget).attr("expensevalue_id"))
    expense_id = Number($(event.currentTarget).attr("expense_id"))
    amount = $("#expense_value_amount").val()
    expense_date = $(event.currentTarget).attr("expense_date")
    is_paid = $("#expense_value_ispaid").attr("checked") is "checked" ? true:false

    expense = @collection.where({id: expense_id})[0]
    expense_value = expense.expenseValues.where({id: id})[0]
    expense_value.set("amount", amount)
    expense_value.set("is_paid", is_paid)
    expense_value.save null, 
      url: "expense_values/#{id}"
      success: (model, response) ->
        $(".popover .modal-body .notice").html("Changes have been saved").addClass("label label-success").fadeIn().fadeOut(5000)

    if $("#apply_future").attr("checked") is "checked"
      Expense.update_future_entries(expense_id, expense_date, amount)


