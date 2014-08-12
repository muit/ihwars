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
    },
    //rangeType => true KM / false miles
    getAreaFromPoint: function(pointLat, pointLon, range, rangeType){
        if(!rangeType) range *= 0.621371;

        var latOffset = (1 / 110.54) * range;
        var lonOffset = (1 / (111.320 * Math.cos(pointLat))) * range;
        //returns {minLat, minLon, maxLat, maxLon};
        return {
            minLat: pointLat-latOffset,
            minLon: pointLon-lonOffset,
            maxLat: pointLat+latOffset,
            maxLon: pointLon+lonOffset
        };
    },
}

var MapSystem = {
    me: undefined,
    area: undefined,
    loadMap: function(){
        var mapOptions = {
            disableDoubleClickZoom: true,
            zoom: 5,
            panControl: false,
            rotateControl: false,
            mapTypeControl: true,
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
                position: google.maps.ControlPosition.BOTTOM_LEFT
            },
            zoomControl: true,
            maxZoom: 19,
            minZoom: 10,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.LARGE,
                position: google.maps.ControlPosition.LEFT_CENTER
            },
            streetViewControl: false,
        };

        map = new google.maps.Map(Util.getId('map-canvas'),
mapOptions);
        
        map.setCenter(new google.maps.LatLng(40.3748241, -3.5915732));
    },
    locateMe: function(){
        navigator.geolocation.getCurrentPosition(function(position) {
            var range = 1
            var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            this.area = Util.getAreaFromPoint(position.coords.latitude, position.coords.longitude, range);

            if(this.me)
                this.me.close();

            this.me = new google.maps.InfoWindow({
                map: map,
                position: pos,
                content: 'Hey, I´m here!'
            });

            map.setCenter(pos);
            map.setOptions({zoom: 16});

            //StationsSystem
            Station.getNear(this.area);
        }, function() {
            Util.createNotification("","", "GeoLocation no obtuvo permiso, o produjo un error.");
        });
    },
}

var Station = {
    nearList: [],
    times: [],
    markersArray: [],
    selected: undefined,

    getNear: function(area){
        //area = {minLat, minLon, maxLat, maxLon}
        var self = this;

        $.get('/stations', area, 
            function(data){
                self.list = data;

                $.each(self.list, function( i, station ) {
                    self.markersArray.push(self.createMarker(station.name, station.lat, station.lon));
                });
            }, "json"
        );
    },
    getInfo: function(id, from_time, to_time){
        console.log("\nStation selected: "+id);              
        console.log(from_time +"-"+to_time);
        var self = this;
        $.get('/stations/'+id+'/times', { from: from_time, to: to_time}, 
            function(times){
                var error = times.shift();
                if(error.message != "")
                    Visual.showError(error.message);
                else{
                    self.times = times;
                    Visual.clearTimes();
                    console.log("Received "+self.times.length+" stoptimes(Station "+id+").");
                    Visual.showStationTimes(self.times);
                }
            }, "json"
        );
    },
    showInfo: function(){
        Visual.showLoadingInfo(true);
    },
    createMarker: function(title, lat, lon){
        var pos = new google.maps.LatLng(lat, lon);
        var self = this;
        var lat = lat;
        var lon = lon;

        var marker = new google.maps.Marker({
            position: pos,
            map: map,
            title: title,
            icon: "assets/marker.png"
        });

        google.maps.event.addListener(marker, 'click', function(){
            self.list.forEach(function(station){
                if (station.name == marker.title)
                    if (station.lat == lat && station.lon == lon)
                        if(station != self.selected){
                            Visual.showStation(station);
                            var now = new Date();
                            var h = now.getHours();
                            var m = now.getMinutes();
                            var s = now.getSeconds();
                            var from = ((h<10)?"0"+h:h)+":"+((m<10)?"0"+m:m)+":"+((s<10)?"0"+s:s);

                            var h2 = h;
                            var m2 = m+30;
                            var s2 = s;
                            if(m2>=60){
                                h2 = h+parseInt(m2/60);
                                m2 %= 60;
                            }
                            var to = ((h2<10)?"0"+h2:h2)+":"+((m2<10)?"0"+m2:m2)+":"+((s<10)?"0"+s:s);
                            self.getInfo(station.id, from, to);
                            self.selected = station;
                        }
            });
        });

        return  marker
    },
}