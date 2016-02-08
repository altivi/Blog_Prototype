function initPage(){
	
	$('#sendComment').click(function(event){
		event.preventDefault();
		sendComment();
	});

	getComments();
	var commentsQueryTimer = setInterval(function(){ //Parse comments every 10sec
		getComments();
	}, 10000);

}

$(function(){
	initPage();
});
$(window).bind('page:change', function(){
	initPage();
});

var allComments = new Array();
var adressPOST = window.location.pathname;
var adressGET = adressPOST + '/json';

function getComments(){
	$.getJSON(adressGET, function(data){
		fillArray(data);
	});
}

function fillArray(data){
	var newComments = 0;
	for(var i = 0; i < data.length; i++){
		var found = false;
		for(var j = 0; j < allComments.length; j++){
			if(allComments[j].id == data[i].id){
				found = true;
				break;
			}
		}
		if(found || data[i].id === undefined) continue;
		newComments++;
		allComments.push(data[i]);
	}
	fillComments(newComments);
}

function fillComments(newComments){
	for(var i = allComments.length - newComments; i < allComments.length; i++){
		var post = $('<div class="post"></div>');
		post.html('<h4><small>' + allComments[i].email + ' says: id:' + allComments[i].id + '</small></h4><div class="well well-sm">' + allComments[i].text + '</div');
		$('#allComments').append(post);
	}
}

function sendComment(){
	var text = $('#comment_area').val();
	if(text.length == 0){
		return;
	}
	$('#comment_area').val('');
	var userId = $.cookie('user_id');
	if(userId.length == 0){
		alert('Session error: can\'t get user_id');
		return;
	}
	var send = {user_id: userId, text: text};
	$.post(adressPOST, $toJSON(send), function(data){
		setTimeout(function(){
			getComments();
		}, 300);
	});
	$('html, body').css('scrollTop', $(document).height());
}