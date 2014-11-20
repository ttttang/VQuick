$(document).ready(function(){
    //Handles menu drop down
    $('.dropdown-menu').find('form').click(function (e) {
    	e.stopPropagation();
    });

    //Allow past events to be hidden
    $(".toggle-events").click(function(){
	  $(".toggleable-events").toggle();
	});


});