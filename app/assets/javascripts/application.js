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
//= require_tree .
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
            $("#timetable").addClass("active");
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

var StationUpdate = {
    updateStationInfo: function(){
        this.showLoading(true);

        $.post('/getStationData', { station_name: "station"}, 
        function(data){
            var object = JSON.parse(data);

            var htmlData = "";
            for(var i = 0, len = object.times.length; i < len; i++)
                htmlData += "<div class='anchor timetablevalue bck light'>"+objects.times[i]+"</div>"

            Util.getId("timetable").innerHTML = htmlData;
            this.showLoading(false);
        },
        function(error){
            this.showLoading(false);
            Util.getId("timetable").innerHTML = "<div class='anchor timetablevalue bck light'>"+"Error Downloading Data"+"</div>";
        });
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
}

var MapSystem = {
    me: undefined,
    loadMap: function(){
        var mapOptions = {
            zoom: 5
        };

        map = new google.maps.Map(Util.getId('map-canvas'),
mapOptions);
        
        map.setCenter(new google.maps.LatLng(40.3748241, -3.5915732));
    },
    locateMe: function(){
        navigator.geolocation.getCurrentPosition(function(position) {
            var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            if(this.me)
                this.me.close();

            this.me = new google.maps.InfoWindow({
                map: map,
                position: pos,
                content: 'Hey, I´m here!'
            });

            map.setCenter(pos);
            map.setOptions({zoom: 15});
        }, function() {
            Util.createNotification("","", "GeoLocation no obtuvo permiso, o produjo un error.");
        });
    }
}

var Util = {
    createNotification: function (img, title, content){

        if (Notification.permission == "granted") {
            var n = new Notification(title, {icon: img, body: content});
            setTimeout(function(){
                n.close();
            },5000);
        }
        else{
            Notification.requestPermission(function(){
                if(Notification.permission == "granted"){
                    var n = new Notification(title, {icon: img, body: content});
                    setTimeout(function(){
                       n.close();
                    },5000);
                }
            });
        }
    },

    setText: function(name, text){
        localStorage.setItem(name, text);
    },

    getText: function(name){
        var a = localStorage.getItem(name);
        if(a == null)
            return "";
        return a;
    },

    getId: function(id){
        return document.getElementById(id);
    },

    Trigger: function(){
        this.state = true;
        this.get = function(){
            var rstate = this.state;
            this.state = false;
            return rstate;
        }
    }
}


