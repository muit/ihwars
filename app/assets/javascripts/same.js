var Base = {
    size: 0,
    selectBase: function(id, name){
        Visual.showInfoPanel(false);
        Visual.showAllTypes(false);
        Visual.baseSelect(id);
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
                    setTimeout(function(){
                        Base.selectBase(this.size-1, name);
                    },500);
                }
            }, "json"
        );
    },
    getBuildingCost: function(buildingType, level, success){
        $.get('/base/building/cost', {type_id: buildingType, level: level},
            function(packet){
                if(packet.object.error != true){
                    success(packet.object.cost);
                }
            }, "json"
        );
    },
    createBuilding: function(buildingType, base_name){
        var self = this;
        //this.getBuildingCost(buildingType, 1, function(cost){
            cost = this.getBuildingCostById(buildingType);
            Visual.createModalConfirm("Building construction", "Build the "+self.getBuildingNameById(buildingType)+" will cost "+cost+"<span class='icon tint'></span><br> Continue?", 
            function(){
                $.get('/base/building/create', {type_id: buildingType, actualBase: base_name}, 
                    function(packet){
                        if(packet.object.error == true)
                            Visual.showAlert(true, packet.object.msg, true);
                        else{ //If not error show the new Building Construction
                            console.log(packet.object.finish_building);
                            Visual.setBuildingStatus(buildingType, 1);
                        }
                    }, "json"
                );
            });
        //});
    },
    updateBuilding: function(buildingType, base_name){

    },

    getBaseAmounts: function(baseName, success, error){
        $.get('/base/info', {actualBase: baseName},
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
    getEntityNameById: function(type_id){
        return this.entity_types.filter(function(x){ return x.type_id == type_id})[0].name;
    },
    getBuildingNameById: function(type_id){
        return this.building_types.filter(function(x){ return x.type_id == type_id})[0].name;
    },
    getEntityCostById: function(type_id){
        return this.entity_types.filter(function(x){ return x.type_id == type_id})[0].cost;
    },
    getBuildingCostById: function(type_id){
        return this.building_types.filter(function(x){ return x.type_id == type_id})[0].cost;
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