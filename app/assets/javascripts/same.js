var Base = {
    size: 0,

    createBase: function(name){
        $.get('/base/create', {name: name}, 
            function(packet){
                console.log(packet);
                if(packet.object.error == true)
                    Visual.showAlert(true, packet.object.msg, true);
                else //If not error show the new Base
                    Visual.createBase(name);
            }, "json"
        );
    },
    createBuilding: function(building_tupe, base_id){
        $.get('/base/build', {type_id: building_type, actualBase: base_id}, 
            function(packet){
                if(packet.object.error == true)
                    Visual.showAlert(true, packer.object.msg, true);
                else{} //If not error show the new Building Construction
            }, "json"
        );
    },

    getBaseData: function(baseName, success, error){
        $.get('/base/info', {actualBase: baseName},
            function(packet){
                if(packet.object.error == true)
                    error(packet.object.msg);
                else
                    success(packet.object.info);
            }, "json"
        );
    },
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

    saveObject: function(name, object){
        localStorage.setItem(name, JSON.stringify(object));
    },

    loadObject: function(name){
        var object = JSON.parse(localStorage.getItem(name));
        if(object == null)
            return "";
        return object;
    },

    Trigger: function(){
        this.state = true;
        this.get = function(){
            var rstate = this.state;
            this.state = false;
            return rstate;
        }
    },
}