// jquery must be first
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require popper
//= require bootstrap
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
      }, 120000); // In every 120 seconds
  });
}

$(document).ready(toggle, update_resources);
$(document).on('turbolinks:load', update_resources);
