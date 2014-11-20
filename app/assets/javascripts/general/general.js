$(document).ready(function(){
    //Handles menu drop down
    $('.dropdown-menu').find('form').click(function (e) {
    	e.stopPropagation();
    });

    //Allow past events to be hidden
    $(".toggleable-events").hide();
    $(".toggleable-event-list").show();


    $(".toggle-events").click(function(){
	  $(".toggleable-events").toggle();
	  $(".toggleable-event-list").toggle();

	});



});