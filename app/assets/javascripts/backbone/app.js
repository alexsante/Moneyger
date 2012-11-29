_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
};

// Models
window.Income = Backbone.Model.extend();

window.IncomeCollection = Backbone.Collection.extend({
	model: Income,
	url: "/incomes"
});

// Views
window.IncomeView = Backbone.View.extend({

	initialize: function(){
		this.model.bind("reset", this.render, this);
		console.log(this.model);
	},

	render: function(eventName){

		period_total = 0;

		_.each(this.model.models, function (income) {
            $(this.el).append(new IncomeTileView({model:income}).render().el);

            if(income.toJSON().amount > 0)
            	period_total += Number(income.toJSON().amount);

        }, this);
        
        // Add a div to clear out the floats
        $(this.el).append("<div style='clear: both'></div>");

        $("#income_tiles_container").html(this.el);

        // Set the period total
        $("#income_period_total").html(formatCurrency(period_total));

	}
});

window.IncomeTileView = Backbone.View.extend({

	template: _.template($("#income_tile_template").html()),

	render: function(eventName){
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	}

});

// Router
var AppRouter = Backbone.Router.extend({

	routes: {
		"": "index"
	},

	index: function(){
		this.incomes = new IncomeCollection();
		this.incomeView = new IncomeView({model: this.incomes});
		this.incomes.fetch();
		
	}
});

var app = new AppRouter();
Backbone.history.start();