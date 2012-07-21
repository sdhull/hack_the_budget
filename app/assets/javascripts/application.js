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
//= require twitter/bootstrap
//= require_tree .


var App = function(){

	/* private */
	var default_topic = 'Placeholder Text';

	/* HTML5 elememt support tester */
	var element_supports_attribute = function(element,attribute){
		var test = document.createElement(element);
		if (attribute in test) {
			return true;
		} else {
			return false;
		}
	};

	/* end private */

	return {

		init: function() {

			if (!element_supports_attribute('input','placeholder')) {
				App.add_focus_events();
			}

		},

		add_focus_events: function(){

			$('#foo').val(default_topic);

			$('#foo').focus(function(){
				if($(this).val()===default_topic){
					$(this).val('');
				}
			});
			$('#foo').blur(function(){
				if($(this).val()===''){
					$(this).val(default_topic);
				}
			});
		}

	};
}();

$(document).ready(function($){
	App.init();
});