var Base = {
    size: 0,
    selectBase: function(id, name){
        Visual.baseSelect(id);
        Visual.showInfoPanel(false);
        Visual.showAllTypes(false);
        this.getBaseAmounts(name, 
            function(entities, buildings){
                Visual.deleteTypes();
                var entityControlDisabled = false;
                for(var i = 0, len = entities.length; i < len; i++){
                    Visual.createEntityType(entities[i].type_id, entities[i].name, entities[i].amount, true);
                    if(entities[i].name == "Barracks" && entities[i].level == 0)
                        entityControlDisabled = true;
                }
                for(var i = 0, len = buildings.length; i < len; i++)
                    Visual.createBuildingType(buildings[i].type_id, buildings[i].name, buildings[i].level, true, entityControlDisabled);
                
                Visual.showAllTypes(true);
            }, 
            function(msg){
                Visual.showAlert(msg);
            }
        );
    },
    createBase: function(name){
        $.get('/base/create', {name: name}, 
            function(packet){
                console.log(packet);
                if(packet.object.error == true)
                    Visual.showAlert(true, packet.object.msg, true);
                else{ //If not error show the new Base
                    Visual.createBase(name);
                    Base.selectBase(this.size-1, name);
                }
            }, "json"
        );
    },
    getCost: function(building_type, level, success){
        $.get('/base/building/cost', {type: building_type, level: level},
            function(packet){
                if(packet.object.error != true){
                    success(packet.object.cost);
                }
            }, "json"
        );
    },
    createBuilding: function(building_tupe, base_id){
        this.getCost(building_tupe, base_id, function(cost){

            Visual.createModalConfirm("Nombre de la nueva base?", function(){
                
            });

            $.get('/base/building/create', {type: building_type, actualBase: base_id}, 
                function(packet){
                    if(packet.object.error == true)
                        Visual.showAlert(true, packer.object.msg, true);
                    else{ //If not error show the new Building Construction
                        console.log(packet.object.finish_building);
                    }
                }, "json"
            );
        });
    },

    getBaseAmounts: function(baseName, success, error){
        $.get('/base/amounts', {actualBase: baseName},
            function(packet){
                if(packet.object.error == true)
                    Visual.showAlert(true, packet.object.msg, true);
                else{
                    entities = packet.object.entities;
                    buildings = packet.object.buildings;
                    success(entities, buildings);
                }
            }, "json"
        );
    },

    Building: {
        getByType: function(baseName, type_id){
            $.get('/base/building/info', 
                {actualBase: baseName, type_id: type_id},
                function(packet){
                    if(packet.object.error == true)
                        Visual.showAlert(true, packet.object.msg, true);
                    else{
                        success(packet.object.buildings);
                    }
                }, "json"
            );
        },
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