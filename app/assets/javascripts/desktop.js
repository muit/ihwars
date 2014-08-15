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
            }, 3000);
        }
    },

    createModalForm: function(msg, success){
        $("#formModal").addClass("active");
        $("#formModal_buttonOK").bind('click', function(event){
            $("#formModal").removeClass("active");
            success(formModal_text.value);
        });
        $("#formModal_buttonNOT").bind('click', function(event){
            $("#formModal").removeClass("active");
        });
    },

    createBase: function(name){
        this.Menu.addBase(name, Base.size);
        Base.size++;
        //Show Base Info <--Here
    },

    baseSelected: function(){
        for(var id = 0; id < Base.size; id++)
        {
            if($("base_name_"+id).hasClass("active"))
                return id;
        }
        return 0;
    },

    showAllTypes: function(value){
        if(!value){
            $(".baseDataTitle").addClass("hidden");
            $(".baseData").addClass("hidden");
            setTimeout(function(){
                $(".baseDataTitle").css("display", "none");
                $(".baseData").css("display", "none");
            }, 500);
        }
        else{
            $(".baseDataTitle").css("display", "block");
            $(".baseData").css("display", "block");
            setTimeout(function(){
                $(".baseDataTitle").removeClass("hidden");
                $(".baseData").removeClass("hidden");
            }, 500);
        }
    },

    showInfoPanel: function(value, title){
        if(!value){
            $(".dataPanelTitle").addClass("hidden");
            $(".dataPanel").addClass("hidden");
            setTimeout(function(){
                $(".dataPanelTitle").css("display", "none");
                $(".dataPanel").css("display", "none");
            }, 500);
        }
        else{
            $(".dataPanelTitle").css("display", "block");
            $(".dataPanel").css("display", "block");
            $(".dataPanelTitle").html(title);
            setTimeout(function(){
                $(".dataPanelTitle").removeClass("hidden");
                $(".dataPanel").removeClass("hidden");
            }, 500);
        }
    },

    Menu: {
        addBase: function(name, id){
            $("#base_list").prepend("<a href='#'><span id='base_name_"+id+"' class='baseName icon building'></span>"+name+"<small></small></a>");
        },
    }
}

$( document ).ready(function() {
    
    $("body").bind('click', function(event) {
        switch($(event.target).attr('id')){
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
        }
        if($(event.target).hasClass("baseData")){
            id = $(event.target).attr("id");
            if(id.indexOf("building_type") != -1){
                Visual.showAllTypes(false);
                //getBuildingData
                Visual.showInfoPanel(true);// , title);
            }

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