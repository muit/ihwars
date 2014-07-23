$( document ).ready(function() {
    MapSystem.loadMap();

    $("body").bind('click', function(event) {
        if($(event.target).attr('id') == "closeaside")
            $("#timetable").removeClass("active");

        if($(event.target).attr('id') == "locateMe")
            MapSystem.locateMe();
        if($(event.target).attr('id') == "closecontrolaside")
            $("#controlmenu").removeClass("active");
    });
    /*
    Marker Click event:
        Add Station Data to '#timetable'
        $("#timetable").addClass("active");
    */

    
});

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
            Notification.requestPermission();

            if(Notification.permission == "granted"){
                var n = new Notification(title, {icon: img, body: content});
                setTimeout(function(){
                    n.close();
                },5000);
            }
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
        state = true;
        get = function(){
            var rstate = state;
            state = false;
            return rstate;
        }
    }
}

