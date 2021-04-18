$(function() {
    $(document).ready(function() {
        setInterval(function() {
        jQuery.ajax({
            url: window.UPDATE_URL,
            type: "GET",
            dataType: "script"
        });
        }, 15000); // In every 15 seconds
    });
});