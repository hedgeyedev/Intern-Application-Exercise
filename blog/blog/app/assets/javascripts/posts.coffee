$(document).on 'turbolinks:load', ->
	return unless page.controller() == 'posts' 

	$('.block-post').append 'hellooooooooooo'

	DisableButton = ->
  		$('.thumb-up').addClass 'hide'
  		$('.like_form').append '<i class=`far fa-thumbs-up thumbs`></i> <%=@post.likes%> hello'
  	return

  	$('.thumb-up').on 'click', DisableButton



	