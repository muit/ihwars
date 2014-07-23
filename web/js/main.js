if (document.body) {
  $("body").bind('click', function(event) {
    console.log(event.target + " " + $("#closeaside"))
    if(event.target == $("#closeaside"))
        $("#timetable").removeClass("active");
  });
}