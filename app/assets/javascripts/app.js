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