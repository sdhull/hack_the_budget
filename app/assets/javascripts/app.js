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
    //console.log("click");
  }

  var load_general_fund_pie = function() {

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
    /*
        $.ajax({url: "/path_to_chart_data",
          data: {
           tag: tag
          },
          success: function(data) {
            chart_data = $.parseJSON(data);
            $.plot($("#pie"), chart_data);
          },
          error: function(data) {
            console.log("Error loading chart data");
          }
        })
    */
  }

  /* end private */

  return {

    init: function() {

      App.add_some_pie();

    },

    add_some_pie: function(){

      load_general_fund_pie();
      $("#pie").bind("plothover", pieHover);
      $("#pie").bind("plotclick", pieClick);

    }
  }

}();

$(document).ready(function($){
  App.init();
});