// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./desktop
//= require same

var Visual = {
    showAlert: function(value){
        (value)? $("#alert").addClass("active") : $("#alert").removeClass("active");
    },
}

$( document ).ready(function() {
    
    $("body").bind('click', function(event) {

        switch($(event.target).attr('id')){
        case "alert_close":
            Visual.showAlert(false);
            break;
        }
    });
    $("body").bind('mouseover', function(event) {

        switch($(event.target).attr('id')){
        }
    });

    $("body").bind('mouseout', function(event) {

        switch($(event.target).attr('id')){
        }
    });
});