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
    showStationTimes: function(times){
        var box = $(".timetablebox")
        times.forEach(function(time){
            box.append("<div class='anchor timetablevalue bck dark'><span class='on-left margin-left'>"+time.arrival+"</span>"+time.headsign+"</div>");
        });
    },
    clearTimes: function(){
        $(".timetablebox").html("");
    },

    showLoading: function(value){
        if(value){
            $("#loadStationData").css("display", "block");
            $("#loadStationData").css("background-color", "rgba(0,0,0,0.8)");
        }else{ 
            $("#loadStationData").css("display", "none");
            $("#loadStationData").css("background-color", "rgba(0,0,0,0.0)");
        }
    },
    showLoadingInfo: function(value){
        if(value)
            $(".timetablebox").html('<div class="anchor timetablevalue bck dark"><div id="loadingInfo"><div id="loading_1" class="loading"></div><div id="loading_2" class="loading"></div><div id="loading_3" class="loading"></div><div id="loading_4" class="loading"></div><div id="loading_5" class="loading"></div><div id="loading_6" class="loading"></div><div id="loading_7" class="loading"></div><div id="loading_8" class="loading"></div></div></div>');
        else
            this.clearTimes();
    },
    showStation: function(station){
        if(typeof(station)==='undefined') station = Station.list[0];
        if(!station) return "There´s no any station";

        if ($("#timetable").hasClass("active")){
            $("#timetable").removeClass("active");
            var self = this;
            setTimeout(function(){
                $("#stationNameShow").text(station.name);
                $("#timetable").addClass("active");
                self.showLoadingInfo(true);
            }, 500);
        }
        else
        {
            $("#stationNameShow").text(station.name);
            $("#timetable").addClass("active");
            Visual.showLoadingInfo(true);
        }
    },
    isInfoShow: function(){
        return $("#timetable").hasClass("active");
    },
    showError: function(message){
        $(".timetablebox").html("<div class='anchor timetablevalue bck dark'>"+message+"</div>");
    }
}

$( document ).ready(function() {
    if(window.google)
        MapSystem.loadMap();
    else
        Util.createNotification("", "Error", "Google Maps doesn´t work! Make sure you have internet.");

    $("body").bind('click', function(event) {

        switch($(event.target).attr('id')){

        case "closeaside":
            $("#timetable").removeClass("active");
            break;
        case "closemenuaside":
            $("#controlmenu").removeClass("active");
            break;
        case "asidebutton":
            if(Station.selected) $("#timetable").addClass("active");
            break;
        case "menuasidebutton":
            $("#controlmenu").addClass("active");
            break;
        case "locateMe":
            if(window.google) 
                MapSystem.locateMe();
            else
                Util.createNotification("", "Error", "Google Maps doesn´t work! Make sure you have internet.");
            break;
        }
    });
    $("body").bind('mouseover', function(event) {

        switch($(event.target).attr('id')){
        case "asidebutton":
            $("#asidebutton").addClass("active");
            break;
        case "menuasidebutton":
            $("#menuasidebutton").addClass("active");
            break;
        }
    });

    $("body").bind('mouseout', function(event) {

        switch($(event.target).attr('id')){
        case "asidebutton":
            $("#asidebutton").removeClass("active");
            break;
        case "menuasidebutton":
            $("#menuasidebutton").removeClass("active");
            break;
        }
    });
});