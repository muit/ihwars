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
    showAlert: function(value, msg, timeout){
        if(!timeout) var timeout = false;
        if(msg) $("#alert_text").html(msg);

        if(value)
            $("#alert").addClass("active");
        else
            $("#alert").removeClass("active");
        if(timeout){
            setTimeout(function(){
                $("#alert").removeClass("active");
            }, 4000);
        }
        $("#alert_buttonNOT").bind('click', function(event){
            $("#alert_buttonNOT").unbind("click");
            $("#alert").removeClass("active");
        });
    },

    createModalForm: function(msg, success){
        $("#formModal").addClass("active");
        $("#formModal_buttonOK").bind('click', function(event){
            $("#formModal_buttonOK").unbind("click");
            $("#formModal").removeClass("active");
            success(formModal_text.value);
        });
        $("#formModal_buttonNOT").bind('click', function(event){
            $("#formModal_buttonNOT").unbind("click");
            $("#formModal").removeClass("active");
        });
    },

    createModalConfirm: function(title, msg, success){
        $("#confirmModal_title").html(title);
        $("#confirmModal_text").html(msg);
        $("#confirmModal").addClass("active");
        $("#confirmModal_buttonOK").bind('click', function(event){
            $("#confirmModal_buttonOK").unbind("click");
            $("#confirmModal").removeClass("active");
            success();
        });
        $("#confirmModal_buttonNOT").bind('click', function(event){
            $("#confirmModal_buttonNOT").unbind("click");
            $("#confirmModal").removeClass("active");
        });
    },

    createBase: function(name){
        this.Menu.addBase(name, Base.size);
        Base.size++;
        if (Base.size >= 5)
            $("#create_base").remove();
        //Show Base Info <--Here
    },

    baseSelected: function(){
        for(var id = 0; id < Base.size; id++)
        {
            if($(".baseName#"+id).hasClass("active"))
                return id;
        }
        return 0;
    },

    baseSelect: function(id){
        $(".baseName").removeClass("active");
        $(".baseName#"+id).addClass("active");
    },

    showAllTypes: function(value, hide){
        if(!hide) hide = false;
        if(!value){
            $(".baseDataTitle").addClass("hidden");
            $(".baseData").addClass("hidden");
            setTimeout(function(){
                if(hide){
                    $(".dataColumn").css("display", "none");
                }
            }, 250);
        }
        else{
            $(".dataColumn").css("display", "block");
            setTimeout(function(){
                $(".baseDataTitle").removeClass("hidden");
                $(".baseData").removeClass("hidden");
            }, 250);
        }
    },

    showInfoPanel: function(value, title){
        if(!value){
            $(".dataPanelTitle").addClass("hidden");
            $(".dataPanel").addClass("hidden");
            setTimeout(function(){
                $(".dataPanelTitle").css("display", "none");
                $(".dataPanel").css("display", "none");
            }, 250);
        }
        else{
            $(".dataPanelTitle").css("display", "block");
            $(".dataPanel").css("display", "block");
            $(".dataPanelTitle").html(title);
            setTimeout(function(){
                $(".dataPanelTitle").removeClass("hidden");
                $(".dataPanel").removeClass("hidden");
            }, 250);
        }
    },
    deleteTypes: function(){
        $(".buildingList").remove();
        $(".entityList").remove();
    },
    createBuildingType: function(type_id, name, level, hidden){
        var hideClass = (hidden)? "hidden" : "";
        if(level != 0)
            var levelOrCreate = "Level: "+level+"  <button class='addBuildingLevel success tiny icon arrow-up'></button>";
        else
            var levelOrCreate = "<button class='createBuilding success tiny'>Build it!</button>";

        $(".dataColumn")[0].innerHTML += "<div id='"+type_id+"' class='buildingList baseData "+hideClass+" column_5 bck grey margin-bottom padding-left padding-right'>"+name+"<div class='on-right'>"+levelOrCreate+"</div></div>";
    },
    createEntityType: function(type_id, name, amount, hidden, disabled){
        var hideClass = (hidden)? "hidden" : "";
        var disabledClass = (disabled)? "disabled" : "";

        $(".dataColumn")[1].innerHTML += "<div id='"+type_id+"' class='entityList baseData "+hideClass+" column_5 bck grey margin-bottom padding-left padding-right'>"+name+"<div class='on-right'><a class='entityAdd color green icon plus-sign "+disabledClass+"'></a><a class='entityRemove color red icon minus-sign "+disabled+"'></a><input type='number' class='entityInput small' value='0' min='0' max='199'>&nbsp<span class='amountType text italic bold color success'>"+amount+"</span></div></div>";
    },
    setBuildingStatus: function(type_id, level){
        if(level != 0)
            $(".buildingList#"+type_id).html(Base.getBuildingNameById(type_id)+"<div class='on-right'>Level: "+level+"  <button class='addBuildingLevel success tiny icon arrow-up'></button></div>");
        else
            $(".buildingList#"+type_id).html(Base.getBuildingNameById(type_id)+"<div class='on-right'><button class='createBuilding success tiny'>Build it!</button></div>");
    },

    Menu: {
        addBase: function(name, id){
            $("#base_list").prepend("<a id='"+id+"' class='baseName'><span class='icon building'></span>"+name+"<small>(1)</small></a>");
        },
        getBaseName: function(id){
            return $(".baseName#"+id).text().replace(/\(.*?\)/, '');
        },
    },
    updateBaseResource: function(baseResource){

    },
    showTotalResources: function(totalResources){
        $(".resource")[0].innerHTML = "  "+totalResources.money;
        $(".resource")[1].innerHTML = "  "+totalResources.materials;
        $(".resource")[2].innerHTML = "  "+totalResources.ping;
    }
}

$( document ).ready(function() {
    $("#combat_result_alert").addClass("active");
    
    $("body").bind('click', function(event) {
        var target = $(event.target);
        switch(target.attr('id')){
        case "create_base":
            Visual.createModalForm("Nombre de la nueva base?", function(name){
                console.log(name);
                if(name == "")
                    Visual.showAlert(true, "El nombre no puede estar vacio.", true);
                else
                    Base.createBase(name);
            });
            break;
        case "remove_flash_alert":
            $("#flash_alert").remove()
            break;
        case "remove_flash_success":
            $("#flash_notice").remove()
            break;
        case "remove_flash_cookies":
            $("#flash_cookies").remove()
            break;
        case "prepare_attack_button":
            $("#attack_alert").addClass("active")
            break;
        case "cancel_attack_alert":
            $("#attack_alert").removeClass("active")
            break;
        case "combat_results_alert_done":
            $("#combat_results_alert").removeClass("active")
            break;
        }

        if(target.hasClass("entityAdd")){

            return;
        }
        else if(target.hasClass("entityRemove")){

            return;
        }
        else if(target.hasClass("addBuildingLevel")){
            var name = Visual.Menu.getBaseName(Visual.baseSelected());
            var type_id = parseInt(target.parent()[0].parentElement.id);
            var level = parseInt($(".buildingList#"+type_id+" >> .building_level").html());

            Base.updateBuilding(type_id, name, level);
            return;
        }
        else if(target.hasClass("createBuilding")){
            var name = Visual.Menu.getBaseName(Visual.baseSelected());
            var type_id = parseInt(target.parent()[0].parentElement.id);
            Base.createBuilding(type_id, name);
            return;
        }

        if(target.hasClass("buildingList")){
            var type_id = parseInt(target.attr('id'));
            var buildingSelected = undefined;
            for(var i = 0, len = Base.building_types.length; i < len; i++){
                if(Base.building_types[i].type_id == type_id) 
                    buildingSelected = Base.building_types[i];
            }

            Visual.showAllTypes(false, true);
            //getBuildingData
            Visual.showInfoPanel(true, buildingSelected.name);
            return;
        }
        else if(target.hasClass("entityList")){
            var type_id = parseInt(target.attr('id'));
            var entitySelected = undefined;
            for(var i = 0, len = Base.entity_types.length; i < len; i++){
                if(Base.entity_types[i].type_id == type_id) 
                    entitySelected = Base.entity_types[i];
            }

            Visual.showAllTypes(false, true);
            //getBuildingData
            Visual.showInfoPanel(true, entitySelected.name);
            return;
        }
        else if(target.hasClass("baseName") && target.attr('id') != "create_base"){
            var id = parseInt(target.attr('id'));
            var name = Visual.Menu.getBaseName(id);

            Base.selectBase(id, name);
            return;
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