// jquery must be first
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
// tree must be last
//= require_tree .

var toggle = function(){
  $(".building_name").click(function(){
    $(this).next().toggle();
  });
};

// update resources on /planets every 15 sec
var update_resources = function() {
  $(document).ready(function() {
      setInterval(function() {
      jQuery.ajax({
          url: window.UPDATE_URL,
          type: "GET",
          dataType: "script"
      });
      }, 15000); // In every 15 seconds
  });
}

$(document).ready(toggle, update_resources);
$(document).on('turbolinks:load', update_resources);
