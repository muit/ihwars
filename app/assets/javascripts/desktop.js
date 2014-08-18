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
    },

    createModalForm: function(msg, success){
        $("#formModal").addClass("active");
        $("#formModal_buttonOK").bind('click', function(event){
            $("#formModal").removeClass("active");
            success(formModal_text.value);
            $("#formModal_buttonOK").unbind("click");
        });
        $("#formModal_buttonNOT").bind('click', function(event){
            $("#formModal").removeClass("active");
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
    createBuildingType: function(type_id, name, amount, hidden){
        hideClass = (hidden)? "hidden" : "";
        $(".dataColumn")[0].innerHTML += "<a href='#'><div id='"+type_id+"' class='buildingList baseData "+hideClass+" column_5 bck grey margin-bottom padding'>"+name+"<div class='on-right'>"+amount+"</div></div></a>";
    },
    createEntityType: function(type_id, name, amount, hidden){
        hideClass = (hidden)? "hidden" : "";
        $(".dataColumn")[1].innerHTML += "<a href='#'><div id='"+type_id+"' class='entityList baseData "+hideClass+" column_5 bck grey margin-bottom padding'>"+name+"<div class='on-right'>"+amount+"</div></div></a>";
    },
    Menu: {
        addBase: function(name, id){
            $("#base_list").prepend("<a href='#'><span id='"+id+"' class='baseName icon building'></span>"+name+"<small></small></a>");
        },
    }
}

$( document ).ready(function() {
    
    $("body").bind('click', function(event) {
        var target = $(event.target);
        switch(target.attr('id')){
        case "alert_close":
            Visual.showAlert(false);
            break;
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
            Visual.showInfoPanel(true, buildingSelected.name);// , title);
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
            Visual.showInfoPanel(true, entitySelected.name);// , title);
        }
        else if(target.hasClass("baseName")){
            var id = parseInt(target.attr('id'));
            var name = target.context.innerText.replace(/\(.*?\)/, '');
            Base.selectBase(id, name);
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