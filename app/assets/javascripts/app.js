var App = function(){

  /* private */
  var default_topic = 'Placeholder Text';

  var pieHover = function(event, pos, obj) {
    if (!obj) {
      return;
    }
    percent = parseFloat(obj.series.percent).toFixed(2);
    $("#hover").html('<span style="font-weight: bold; color: '+obj.series.color+'">'+obj.series.label+' ('+percent+'%)</span>');
  }
  
  var pieClick = function(event, pos, obj) {
    alert("click");
  }

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

      if (element_supports_attribute('input','placeholder')) {
        App.add_focus_events();
        App.add_some_pie();
        App.load_chart_data();
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
    },
    
    add_some_pie: function(){

      var data = [];
      var series = Math.floor(Math.random()*10)+1;
      for( var i = 0; i<series; i++)
      {
        data[i] = { label: "Series"+(i+1), data: Math.floor(Math.random() * 100)+1 }
      }
      
      // DEFAULT
      $.plot($("#pie"), data, {
          series: {
            pie: { 
              show: true
            }
          },
          grid: {
            hoverable: true,
            clickable: true
          }
      });

      $("#pie").bind("plothover", pieHover);
      $("#pie").bind("plotclick", pieClick);

    },
  
    // Load and set the chart data to our ajax method
    load_chart_data: function(tag) {
	  $.ajax({
	    url: "/path_to_chart_data",    
	      data: {
	       tag: tag
	      },
	      success: function(data) {
	        chart_data = $.parseJSON(data);
	        $.plot($("#pie"), chart_data);
	      },
	      error: function(data) {
	        alert("Error loading chart data");
	      }
	  })
    }
  }
}();

$(document).ready(function($){
  App.init();
});