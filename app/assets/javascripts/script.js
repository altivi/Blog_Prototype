function initPage(){
	
	$('#sendComment').click(function(event){
		event.preventDefault();
		sendComment();
	});

	getComments();
	var commentsQueryTimer = setInterval(function(){ //Parse comments every 10sec
		getComments();
	}, 5000);

}

$(function(){
	initPage();
});
$(window).bind('page:change', function(){
	initPage();
});

var comments = new Array();
var adressPOST = window.location.pathname;
var adressGET = adressPOST + '.json';

function getComments(){
	$.getJSON(adressGET, function(data){
		fillArray(data);
	});
}

function fillArray(data){
	var newComments = 0;
	for(var i = 0; i < data.length; i++){
		var found = false;
		for(var j = 0; j < comments.length; j++){
			if(comments[j].id == data[i].id){
				found = true;
				break;
			}
		}
		if(found || data[i].id === undefined) continue;
		newComments++;
		comments.push(data[i]);
	}
	fillComments(newComments);
}

function fillComments(newComments){
	for(var i = comments.length - newComments; i < comments.length; i++){
		var post = $('<div class="post"></div>');
		post.html('<h4><small>' + comments[i].user.email + ' says:' + '</small></h4><div class="well well-sm">' + comments[i].text + '</div');
		$('#comments').append(post);
	}
}

function sendComment(){
	var text = $('#comment_area').val();
	if(text.length == 0){
		return;
	}
	$('#comment_area').val('');
	var send = {user_id: userId, text: text};
	$.post(adressPOST, $toJSON(send), function(data){
		setTimeout(function(){
			getComments();
		}, 300);
	});
	$('html, body').css('scrollTop', $(document).height());
}