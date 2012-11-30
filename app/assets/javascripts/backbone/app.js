window.Moneyger = {
	Models: {},
	Views: {},
	Collections: {},
	Routers: {},

}

_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
};

$(document).ready(function() {
	window.App = new Moneyger.Routers.AppRouter;
	Backbone.history.start()
});