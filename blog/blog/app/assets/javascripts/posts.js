$(function() {
    attachListeners();
    
});
// attach the listeners of the element that display on the document
function attachListeners() {
    $(".block-post").on("click", sayHi);        
}

function sayHi() {
	console.log("hi")
}