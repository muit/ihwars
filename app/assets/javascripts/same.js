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

                for(var i = 0, len = buildings.length; i < len; i++){
                    if(buildings[i].name == "Barracks" && buildings[i].level == 0)
                        entityControlDisabled = true;
                    Visual.createBuildingType(buildings[i].type_id, buildings[i].name, buildings[i].level, true);
                }

                for(var i = 0, len = entities.length; i < len; i++){
                    Visual.createEntityType(entities[i].type_id, entities[i].name, entities[i].amount, true, entityControlDisabled);
                }
                
                Visual.showAllTypes(true);
                Util.saveSelectedBase(name);
            }, 
            function(msg){
                Visual.showAlert(true, msg, true);
            }
        );
    },
    createBase: function(name){
        var self = this;
        $.get('/base/create', {name: name}, 
            function(packet){
                if(packet.object.error == true)
                    Visual.showAlert(true, packet.object.msg, true);
                else{ //If not error show the new Base
                    Visual.createBase(name);
                    setTimeout(function(){
                        Base.selectBase(self.size-1, name);
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
            var cost = this.getBuildingCostById(buildingType);
            Visual.createModalConfirm("Building construction", "Build the "+self.getBuildingNameById(buildingType)+" will cost "+cost+"<span class='icon tint'></span><br> Continue?", 
            function(){
                $.get('/base/building/create', {type_id: buildingType, actualBase: base_name}, 
                    function(packet){
                        if(packet.object.error == true)
                            Visual.showAlert(true, packet.object.msg, true);
                        else{ //If not error show the new Building Construction
                            Visual.setBuildingStatus(buildingType, 1);
                        }
                    }, "json"
                );
            });
        //});
    },
    updateBuilding: function(buildingType, base_name, level){
        var self = this;
        this.getBuildingCost(buildingType, level+1, function(cost){
            Visual.createModalConfirm("Building update", "Updating the "+self.getBuildingNameById(buildingType)+" will cost "+cost+"<span class='icon tint'></span><br> Continue?", 
            function(){
                $.get('/base/building/update', {type_id: buildingType, actualBase: base_name}, 
                    function(packet){
                        if(packet.object.error == true)
                            Visual.showAlert(true, packet.object.msg, true);
                        else{ //If not error show the new Building Construction
                            console.log(packet.object.finish_building);
                            Visual.setBuildingStatus(buildingType, level+1);
                            this.updateResources();
                        }
                    }, "json"
                );
            });
        });
    },

    addEntities: function(entityType, amount, base_name){
        var self = this;
        var cost = this.getEntityCostById(entityType)*amount;
        Visual.createModalConfirm("Add entities", "Adding "+amount+" '"+self.getEntityNameById(entityType)+"' units will cost "+cost+"<span class='icon money'></span><br> Continue?", 
        function(){
            $.get('/base/entity/add', {type_id: entityType, amount: amount, actualBase: base_name}, 
                function(packet){
                    if(packet.object.error == true)
                        Visual.showAlert(true, packet.object.msg, true);
                    else{ //If not error show the new Building Construction
                        Visual.showEntityAmount(entityType, packet.object.amount);
                    }
                }, "json"
            );
        });
    },
    removeEntities: function(entityType, amount, base_name){
        var self = this;
        var cost = this.getEntityCostById(entityType)*amount*0.75;
        Visual.createModalConfirm("Remove entities", "Removing "+amount+" '"+self.getEntityNameById(entityType)+"' units will return only 75% of the original price ("+cost+"<span class='icon money'></span>)<br> Continue?", 
        function(){
            $.get('/base/entity/remove', {type_id: entityType, amount: amount, actualBase: base_name}, 
                function(packet){
                    if(packet.object.error == true)
                        Visual.showAlert(true, packet.object.msg, true);
                    else{ //If not error show the new Building Construction
                        //Visual.setEntityType(packet.object.amount);
                    }
                }, "json"
            );
        });
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

    getResources: function(baseName, success){
        $.get('/user/resources', 
            {actualBase: baseName},
            function(packet){
                if(packet.object.error == true)
                    Visual.showAlert(true, packet.object.msg, true);
                else{
                    //return an array of each base hash recourses 
                    success(packet.object.resources);
                }
            }, "json"
        );
    },

    updateResources: function(){
        var baseName = Visual.Menu.getBaseName(Visual.baseSelected());
        
        this.getResources(baseName, function(baseResources){
            totalResources = {money: 0, materials: 0, ping: 0};

            baseResources.forEach(function(baseResource) {
                Visual.updateBaseResource(baseResource);

                totalResources.money += baseResource.money;
                totalResources.materials += baseResource.materials;
                totalResources.ping += baseResource.ping;
            });

            Visual.showTotalResources(totalResources);
        });
    }
}
var Util = {

    loadSelectedBase: function(){
        return this.loadObject("selectedBase");
    },
    saveSelectedBase: function(name){
        this.saveObject("selectedBase", name);
    },
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
        return JSON.parse(localStorage.getItem(name));
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
//Update Resources Aproximation
setTimeout(function(){
    Base.updateResources();
    setInterval(function(){
        Base.updateResources();
    }, 10000);
},1000);