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
      }, 120000); // In every 120 seconds
  });
}

// display upgrade btn
// hide progress bar and cancel btn
function display_upgrade_btn(btn_id) {
  var upgrade_btn = "upgrade_btn_" + btn_id;
  var cancel_btn = "cancel_btn_" + btn_id;
  var progess_bar = "progress_bar_" + btn_id;
  document.getElementById(upgrade_btn).style.display = "inline";
  document.getElementById(cancel_btn).style.display = "none";
  document.getElementById(progess_bar).style.display = "none";
}

// display cancel btn and progress bar
// hide upgrade btn
function display_cancel_btn(btn_id) {
  var upgrade_btn = "upgrade_btn_" + btn_id;
  var cancel_btn = "cancel_btn_" + btn_id;
  var progess_bar = "progress_bar_" + btn_id;
  document.getElementById(upgrade_btn).style.display = "none";
  document.getElementById(cancel_btn).style.display = "inline";
  document.getElementById(progess_bar).style.display = "inline";
}

$(document).ready(toggle, update_resources);
$(document).on('turbolinks:load', update_resources);
