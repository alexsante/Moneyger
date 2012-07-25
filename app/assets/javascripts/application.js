// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.editinplace
//= require bootstrap
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-transition
//= require underscore
//= require backbone
//= require .//moneyger
//= require_tree .//models
//= require_tree .//collections
//= require_tree .//views
//= require_tree .//routers
// //= require_tree .

$(".datepicker").datepicker({dateFormat: "yy/mm/dd"})

function formatCurrency(num) {
    return accounting.formatMoney(num);
}

function dialog(title, content, cb)
{
	
	$('<div></div>').appendTo('body')
	                    .html(content)
	                    .dialog({
	                        modal: true, title: title, zIndex: 10000, autoOpen: true,
	                        width: 'auto', modal: true, resizable: false,
	                        buttons: {
	                           
	                            No: function () {
	                                $(this).dialog("destroy");
	                            },
	                            Yes: function(){
	                            	setTimeout(cb,0);
	                            }
	                        },
	                        close: function (event, ui) {
	                            $(this).remove();
	                        }
	                    });
}


