// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require social-share-button

$(function() {
    attachListeners();
    
});
// attach the listeners of the element that display on the document
function attachListeners() {
    $(".thumb-up").on("click", disableButton);        
}

function disableButton() {
	
	$('#form_to_disable').one('submit', function() {
		
    	$(this).find('button[type="submit"]').attr('disabled','disabled');
	});
	// var buttonLike = document.getElementsByClassName("thumb-up");
	// buttonLike.type = "";
	// $('.like_form').append(`
	// 	<button type="text" class="thumb-up">
	//     	<i class="far fa-thumbs-up thumbs"></i> <%=@post.likes%>
	// 	</button>
	// `)
	// $('.thumb-up').addClass('hide');
	// $('.like_form').append('<i class=`far fa-thumbs-up thumbs`></i> <%=@post.likes%> hello')
}
