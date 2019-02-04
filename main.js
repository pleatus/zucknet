$(document).ready(function() {
	//check to see if #greeting exists, if it does you're signed in
	/*$(document).click(function(){
		console.log(history.state);
	});*/
	if($('#greeting') != null) {
		/*$('#greeting').click(function(){
			console.log('i felt that!');
		});*/
		//atIndex = true;
		initUserMenu();
		if ($('#userMenuId').val() != null) {
			showMainFeed();
		}
	}

	$('#znLogo').mouseup(function () {
		//history.pushState(window.location = 'index.php','mainfeed','index.php');
		removePS();
		removeSearchBox();
		restorePostBox();
		showMainFeed();
	});
	/*$('input[name=postUp]').mouseup(function(){
		setTimeout(removePS(),4000);
	});*/
});

function removePS() {
	if($('#postStatus') != null){
		$('#postStatus').remove();
	}
}

//inits the user menu if there's a login (#greeting will only exist in login state)
function initUserMenu() {
	$('#userMenuBeeps').mouseup(function(){
		removePS();
		removeSearchBox();
		restorePostBox();
		$('#userAppArea').empty();
		renderUserBeeps();
		//$('#userAppArea').append('<h3>USER BEEPS</h3>');
	});
	$('#userMenuProfile').mouseup(function(){
		removePS();
		removeSearchBox();
		restorePostBox();
		$('#userAppArea').empty();
		history.pushState(renderUserProfile(),'preProfile','index.php?preProfile');
		//setTimeout(function(){window.location = 'index.php?preProfile';},1000);
	});
	$('#userMenuFind').mouseup(function(){
		removePS();
		removeSearchBox();
		$('#userAppArea').empty();
		$('#userpostbox').hide();
		history.pushState(renderSearchPage(),'preSearch','index.php?search');
	});
	$('#userMenuJo').mouseup(function(){
		$('#userAppArea').empty();
		userJackOut();
		//$('#userAppArea').append('<h3>USER JO</h3>');
	});
}
function restorePostBox() {
	if($('#userpostbox').hide()) {
		$('#userpostbox').show();
	}
}
function removeSearchBox() {
	if($('#usersearchbox')) {
		$('#usersearchbox').remove();
	}
}

function showMainFeed() {
	let uid = $('#userMenuId').val();
	let q = 'mainfeed=' + uid;

	$.ajax({
		url:'mainfeed.php',
		type:'get',
		beforeSend: function(xhr){
			xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
		},
		data:q,
		dataType:'json',
		success:function(results) {
			renderMainFeed(results);
		},
		error:function(){
			alert('Error retrieving main feed');
		}
	});
}

function renderMainFeed(r) {
	let uid = $('#userMenuId').val();
	console.log(r);
	let feedElm = '';
	let idTracker = new Array();
	r.sort(comp);
	//let resort = postResort(r);
	for (var i = 0;i < r.length;i++) {
		let dupeTrack = idTracker.indexOf(parseInt(r[i].idpost))
		//console.log(dupeTrack);
		if (dupeTrack == -1 || parseInt(r[i].idpost) == uid) {
			let proPost = '<div class="row feedPost" id="p' + r[i].idpost + '">' +
					  '<div class="col-md-2">' +
					  '<img class="userPostPhoto" src="' + r[i].photo_path + '" alt="' + r[i].fname + ' ' + r[i].lname + ' on Zucknet">' +
					  '</div>' +
					  '<div class="col-md-8">' +
					  '<h5>' + r[i].fname + ' is ' + r[i].contents + '</h5>' +
					  '<div class="postInteractions">' +
					  '<span class="col-md-3"><button class="coolPost" id="cp' + r[i].idpost + '">Cool!</button></span>' +
					  '<span class="col-md-3"><button class="lamePost" id="lp' + r[i].idpost + '">Lame!</button></span>' +
					  '<span class="col-md-3"><button class="commentPost" id="cm' + r[i].idpost + '">Comment</button></span>' +
					  '</div>' +
					  '<div class="postTime"><p>Posted: ' + r[i].post_time + '</p>' +
					  '</div>' + 
					  '</div></div>';
			idTracker.push(parseInt(r[i].idpost));
			feedElm += proPost;
		}
		//console.log('feed post loop' + i);
	}
	$('#userAppArea').empty();
	$('#userAppArea').prepend(feedElm);
	handlePostInteract();
}

function handlePostInteract(){
	let coolPost = document.getElementsByClassName('coolPost');
	let lamePost = document.getElementsByClassName('lamePost');
	let commentPost = document.getElementsByClassName('commentPost');
	for (var i = 0;i<coolPost.length;i++){
		coolPost[i].onmouseup = function() {
			setPostInteract(this.id);
			console.log(this.id);
		}
		lamePost[i].onmouseup = function() {
			setPostInteract(this.id);
			console.log(this.id);
		}
		commentPost[i].onmouseup = function() {
			setPostInteract(this.id);
			console.log(this.id);
		}
	}
}

function setPostInteract(id) {
	let uid = $('#userMenuId').val();
	let clcode = 'cp',lmcode = 'lp',cmcode = 'cm';
	let qVar = 'interact=' + id + '&uid=' + uid;
	if(id.indexOf(cmcode) != -1) {
		//post is cool
		renderPostComments(id);
	}
	if(id.indexOf(clcode) != -1 || id.indexOf(lmcode) != -1) {
		$.ajax({
			url:'postinteract.php',
			type:'post',
			data:qVar,
			beforeSend: function(xhr) {
				xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
			},
			success:function(message) {
				if(message != '') {
					alert(message);
				}
			},
			error:function (){
				alert('Something went wrong setting the post interaction');
			}
		});
	}
}

function comp(a,b) {
	return new Date(b.post_time).getTime() - new Date(a.post_time).getTime()
}

function renderUserBeeps() {
	let uid = $('#userMenuId').val();
	let q = 'beepget=2&uid=' +uid;
	
	$.ajax({
		url:'beeps.php',
		dataType:'json',
		data:q,
		type:'get',
		beforeSend:function(xhr){
			xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
		},
		success:function(results){
			dispUserBeeps(results);
			console.log(results);
		},
		error:function(){
			alert('Error getting beeps.');
		}
	});
}

function dispUserBeeps(r) {
	let beepElms = '';
	
	for (var i = 0;i < r.length;i++) {
		let beepCard = '<div class="row beepCard">' +
						  '<div class="col-md-2 col-md-offset-1">' +
						  '<img class="userPostPhoto" src="' + r[i].photo_path + '" alt="' + r[i].fname + ' ' + r[i].lname + ' on Zucknet">' +
						  '</div>' +
						  '<div class="col-md-8">' +
						  '<p>' + r[i].fname + ' ' + r[i].lname  + '</p>' +
						  '<div><button class="approveFriend" id="af' + r[i].iduser + '">Approve</button>' +
						  '<button class="denyFriend" id="df' + r[i].iduser + '">Deny</button>' +
						  '</div>' + 
						  '</div></div>';
		beepElms += beepCard;
	}
	$('#userAppArea').append('<div id="beepsHeader" class="row"><div class="col-md-8 col-md-offset-2">' +
							'<h3>Beeps</h3></div></div>');
	$('#userAppArea').append(beepElms);
	
	let approveButtons = document.getElementsByClassName('approveFriend');
	let denyButtons = document.getElementsByClassName('denyFriend');
	
	for (var i = 0;i<approveButtons.length;i++) {
		approveButtons[i].onmouseup = function() {
			respondFriendRequest(this.id);
		}
		denyButtons[i].onmouseup = function() {
			respondFriendRequest(this.id);
		}
	}
	
}

function respondFriendRequest(id) {
	let uid = $('#userMenuId').val();
	let q = 'fa=' + id + '&uid=' + uid;
	
	$.ajax({
		url:'friends.php',
		type:'post',
		data:q,
		beforeSend:function(xhr){
			xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		},
		success:function(message){
			let confirmAct = confirm(message);
			if(confirmAct){
				$('#userAppArea').empty();
				renderUserBeeps();
			}
			else{
				$('#userAppArea').empty();
				renderUserBeeps();
			}
		},
		error:function(){
			alert('Something went wrong with the friend interaction');
		}
	});
}

function renderPostComments(id) {
	//console.log($('#p' + id.substr(3)));
	let parentPost = $('#p' + id.substr(2));
	$('#userAppArea').empty();
	$('#userAppArea').append(parentPost);
	$('button.coolPost').remove();
	$('button.lamePost').remove();
	$('button.commentPost').remove();
	let q = 'comment=' + id;

	
	$.ajax({
		url:'postinteract.php',
		type:'get',
		data:q,
		dataType:'json',
		beforeSend:function(xhr){
			xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		},
		success:function(r) {
			postComments(r,id);
		},
		error:function() {
			alert('Error getting comments for this post');
		}
	});
	
}

function postComments(r,id) {
	let comElms = '';
	
	for (var i = 0;i < r.length;i++) {
		let commentCard = '<div class="row postComment" id="c' + r[i].idcomment + '">' +
						  '<div class="col-md-2 col-md-offset-1">' +
						  '<img class="userPostPhoto" src="' + r[i].photo_path + '" alt="' + r[i].fname + ' ' + r[i].lname + ' on Zucknet">' +
						  '</div>' +
						  '<div class="col-md-8">' +
						  '<p>' + r[i].fname + ' ' + r[i].lname  + '</p>' +
						  '<p>' + r[i].contents + '</p>' +
						  '<div class="postTime"><p>Posted: ' + r[i].post_time + '</p>' +
						  '</div>' + 
						  '</div></div>';
		comElms += commentCard;
	}
	$('#userAppArea').append(
							'<div id="postcommentbox" class="row">' +
							'<div class="col-md-3"></div>' +
							'<div class="col-md-6">' +
							'<input id="commentcontents" name="commentcontents" type="text">' +
							'<button class="btn" id="userpostcomment">Post Comment</button>' +
							'</div>' +
							'<div class="col-md-3"></div>' +
							'</div>');
	$('#userAppArea').append(comElms);
	
	$('#userpostcomment').unbind('mouseup').mouseup(function(){
		let userComment = $('#commentcontents').val()
		let pid = id;
		let uid = $('#userMenuId').val();
		let q = 'postCom=1' + '&pid=' + pid + '&uid=' + uid + '&com=' + userComment;
		$.ajax({
			url:'postinteract.php',
			type:'post',
			data:q,
			beforeSend:function(xhr){
				xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			},
			success:function(res){
				let commentConfirm = confirm(res);
				if(commentConfirm) {
					renderPostComments(pid);
				}
				else {
					renderPostComments(pid);
				}
			},
			error:function(){
				alert('Error posting comment.');
			}
		});
		
	});
}

function renderSearchPage() {
	$('#userAppArea').append('<div id="searchHeader" class="row"><div class="col-md-8 col-md-offset-2">' +
								 '<h3>Find Zuckers</h3></div></div>');
	$('#userpostbox').before('<div id="usersearchbox">' +
									'<input id="searchcontents" name="searchcontents" type="email">' +
									'<button class="btn" id="startSearch">Search</button>' +
									'</div>');
	$('#startSearch').mouseup(function(){
		$('.userSearchResult').remove();
		let uSeQuery = 'search=' + $('#searchcontents').val();
		searchUsers(uSeQuery);
	});
	$('#searchcontents').keyup(function(e) {
		if (e.which == 13) {
		$('#startSearch').mouseup();
		}
	});
}

function searchUsers(q) {
	$('#searchcontents').select();
		$.ajax({
			url:'search.php',
			type:'get',
			dataType:'json',
			beforeSend:function(xhr){
				xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			},
			data:q,
			success:function(response) {
				renderSearchResults(response);
			},
			error:function() {
				alert('Error starting search');
			}
		});
}

function renderSearchResults(r) {
	console.log(r);
	let seReElm = '';
		for (var i = 0;i < r.length;i++) {
					let seReCard = '<div class="row userSearchResult">' +
							  '<div class="col-md-4">' +
							  '<img class="userSearchPhoto" src="' + r[i].photo_path + '" alt="' + r[i].fname + ' ' + r[i].lname + ' on Zucknet">' +
							  '</div>' +
							  '<div class="col-md-6">' +
							  '<ul class="listSRInfo">' +
							  '<li>' + r[i].fname + ' ' + r[i].lname + '</li>' +	
							  '<li>' + r[i].city + '</li>' +
							  '</ul>' + 
							  '</div>' +
							  '<div class="col-md-2"><ul class="listSRActions">' + 
							  '<li><a href="#" id="userSearchAdd"><input id="addId" type="hidden" value="' + r[i].iduser + '">Add Friend</a></li>' +
							  '</ul></div></div>';
					seReElm += seReCard;
				}
	$('#userAppArea').append(seReElm);
	$('#userSearchAdd').mouseup(function(){
		let uidAdd = $('#addId').val();
		requestFriend(uidAdd);
		console.log('the user id to check and add is ' + uidAdd);
		return false;
	});
}

function requestFriend (id) {
	if(confirmRequest()){
		let uid = $('#userMenuId').val();
		let rId = id;
		let q = 'srid=' + uid + '&seid=' + rId;
		
		$.ajax({
			url:'makeconnection.php',
			type:'post',
			data:q,
			beforeSend: function (xhr) {
				xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			},
			success: function(response) {
				if (response) {
					alert(response);
				}
			},
			error:function(){
				alert('Error trying to add friend.');
			}
		});
	}
}

function confirmRequest() {
	let cR = confirm('Are you sure you want to add this person?');
	if(cR) {
		return true;
	}
	else {
		return false;
	}
}

function userJackOut() {
	let q = 'jackout=Jack+Out';
	$.ajax({
		url:'jackin.php',
		data:q,
		type:'get',
		beforeSend:function(xhr){
			xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		},
		success: function() {
			console.log('jacked out from user modal menu');
			showMainFeed = null;
			window.location = 'index.php';
		},
		error: function() {
			alert('Error Jacking Out');
		}
	});
}

function renderUserProfile() {
	let uid = $('#userMenuId').val();
	let q = 'userPro=' + uid;
	let profData = '';
	//call to server script for profile data
	$.ajax({
		url:"userprofile.php",
		type:"GET",
		beforeSend: function(xhr){
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		},
		data:q,
		dataType:"json",
		success: function (results){
			profData = results;
			//console.log(profData);
			history.pushState(drawProfile(profData,uid),'userprofile','index.php?profile');
			
		},
		error: function() {
			alert('Something bad happened!');
		}
	});
	

}
function editProfile(info,uid) {
	let proInfo = info;
	//console.log(proInfo);
	let userProCard = 
				  '<div class="row" id="userProCard">' +
				  '<div class="col-md-4">' +
				  '<img id="userProfilePhoto" src="' + proInfo.photo_path + '" alt="' + proInfo.fname + ' ' + proInfo.lname + ' on Zucknet">' +
				  '<form type="POST" action="" name="profilePicture"><input type="file" name="userProPic">' +
				  '<br><input type="submit" name="setNewPic" value="Set Picture"></form>' +
				  '</div>' +
				  '<div class="col-md-6">' +
				  '<ul id="listProInfo">' +
				  '<li><input placeholder="Your tagline" type="text" name="edTagline" value="' + proInfo.tagline + '"></li>' +
				  '<li><input placeholder="First name" type="text" name="edFName" value="' + proInfo.fname + '"></li>' + 
				  '<input placeholder="Last name" type="text" name="edLName" value="' + proInfo.lname + '"></li>' +	
				  '<li><input placeholder="Your tagline" type="text" name="edCity" value="' + proInfo.city + '"></li>' +
				  '</ul>' +
				  '<button id="submitEditPro">Save</button><button id="proEditCan">Cancel</button>' +
				  '</div>' +
				  '<div class="col-md-2">' + 
				  '</div>' +
				  '</div>';
	$('#userAppArea').append(userProCard);
	$('form[name=profilePicture]').submit(function(e) {
		let picData = $('input[name=userProPic]').prop('files')[0];
		let formData = new FormData($(this)[0]);
		formData.append('userProPic',picData);
		console.log(formData);
		$.ajax({
			url:'userprofile.php',
			type:'POST',
			/*beforeSend: function(xhr){
				xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			},*/
			data:formData,
			cache:false,
			contentType:false,
			processData:false,
			success: function() {
				$('#userProCard').remove();
				$('.proPost').remove();
				history.pushState(renderUserProfile(),'preProfile','index.php?preProfile');
			},
			error: function() {
				alert('Error saving profile changes.');
			}
		});
		e.preventDefault();
	});
	$('#proEditCan').mouseup(function() {
		$('#userProCard').remove();
		$('.proPost').remove();
		renderUserProfile();
	});
	$('#submitEditPro').mouseup(function() {
		$('#submitEditPro').attr('disabled',true);
		let varString = 'edPro=true&tl=' + $('input[name=edTagline]').val() + '&fn=' +
						$('input[name=edFName]').val() + '&ln=' + $('input[name=edLName]').val() +
						'&cy=' + $('input[name=edCity]').val() + '&uid=' + uid;
		$.ajax({
			url:'userprofile.php',
			type:'POST',
			beforeSend: function(xhr){
				xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			},
			data:varString,
			success: function() {
				$('#userProCard').remove();
				$('.proPost').remove();
				history.pushState(renderUserProfile(),'preProfile','index.php?preProfile');
			},
			error: function() {
				alert('Error saving profile changes.');
			}
		});
	});
}
function drawProfile(pD,uid) {
	let proInfo = pD[0];
	
	let userProCard = 
				  '<div class="row" id="userProCard">' +
				  '<div class="col-md-4">' +
				  '<img id="userProfilePhoto" src="' + proInfo.photo_path + '" alt="' + proInfo.fname + ' ' + proInfo.lname + ' on Zucknet">' +
				  '</div>' +
				  '<div class="col-md-6">' +
				  '<ul id="listProInfo">' +
				  '<li>' + proInfo.tagline + '</li>' +
				  '<li>' + proInfo.fname + ' ' + proInfo.lname + '</li>' +	
				  '<li>' + proInfo.city + '</li>' +
				  '</ul>' + 
				  '</div>' +
				  '<div class="col-md-2"><ul id="listProActions">' + 
				  '<li><a href="" id="userViewFriends">Friends</a></li>' +
				  '<li><a href="" id="userEditProfile">Edit Profile</a></li>' +
				  '</ul></div>' +
				  '</div>';
	//let userProPosts = new Array();
	$('#userAppArea').append(userProCard);
	$('#userViewFriends').mouseup(function() {
		$('#userProCard').remove();
		$('.proPost').remove();
		history.pushState(queryFriends(uid),'friendlist','index.php?friends');
	});
	$('#userEditProfile').mouseup(function() {
		$('#userProCard').remove();
		$('.proPost').remove();
		history.pushState(editProfile(proInfo,uid),'editprofile','index.php?editprofile');
		//editProfile(proInfo,uid);
	});
	if (pD.length > 1) {
		displayPosts(pD,$('#userAppArea'));
	}
	console.log(pD);

	/*while (proInfo.contents) {
		let proPost = '<div class="row"><div class="proPost col-md-8 col-md-offset-2">' +
					  '<h5>' + proInfo.fname + ' is ' + proInfo.contents + '</h5>' +
					  '</div></div>';
		$('#userAppArea').append(proPost);
	}*/
	

}
function displayPosts(postData,parEl) {
	let proPosts = new Object();
		let postElm = '';
		for (var i = 1;i < postData.length;i++) {
			proPosts[i] = postData[i];
			let proPost = '<div class="row proPost">' +
					  '<div class="col-md-2">' +
					  '<img class="userPostPhoto" src="' + postData[0].photo_path + '" alt="' + postData[0].fname + ' ' + postData[0].lname + ' on Zucknet">' +
					  '</div>' +
					  '<div class="col-md-8">' +
					  '<h5>' + postData[0].fname + ' is ' + proPosts[i].contents + '</h5>' +
					  '<div class="postInteractions">' +
					  '<span class="coolPost col-md-3"><a href="">Cool!</a></span>' +
					  '<span class="lamePost col-md-3"><a href="">Lame!</a></span>' +
					  '<span class="commentPost col-md-3"><a href="">Comment</a></span>' +
					  '</div>' +
					  '<div class="postTime"><p>Posted: ' + proPosts[i].post_time + '</p></div>' +
					  '</div></div>';
			postElm += proPost;
		}
		parEl.append(postElm);
		proPosts = new Object();
}

function queryFriends(uid) {
	
	let varString = 'uid=' + uid;
	let qRes = new Object();
	
	$.ajax({
		url:'friends.php',
		type:'GET',
		dataType:'json',
		beforeSend: function(xhr){
			xhr.setRequestHeader('Content-Type','application/x-www-urlformencoded');
		},
		data:varString,
		success:function(results) {
			qRes = results;
			console.log(qRes);
			drawFriends(qRes,uid);
			qRes = new Object();
		},
		error:function() {
			alert('querying for friends was no good. are you sure you have any?');
		}
	});
	
}
function drawFriends(data,uid) {
	let friElm = '';
	let idTracker = new Array();
		for (var i = 0;i < data.length;i++) {
			let dupeTrack = idTracker.indexOf(parseInt(data[i].iduser))
			console.log(dupeTrack);
				if (dupeTrack == -1) {
					let friCard = '<div class="row userFriendCard">' +
							  '<div class="col-md-4">' +
							  '<img class="userPostPhoto" src="' + data[i].photo_path + '" alt="' + data[i].fname + ' ' + data[i].lname + ' on Zucknet">' +
							  '</div>' +
							  '<div class="col-md-6">' +
							  '<ul id="listFriInfo">' +
							  '<li>' + data[i].tagline + '</li>' +
							  '<li>' + data[i].fname + ' ' + data[i].lname + '</li>' +	
							  '<li>' + data[i].city + '</li>' +
							  '</ul>' + 
							  '</div>' +
							  '<div class="col-md-2"><ul id="listFriActions">' + 
							  '<li><a href="" class="userViewFriend">View Profile</a></li>' +
							  '<li><a href="" class="userRemoveFriend">Remove</a></li>' +
							  '</ul></div></div>';
					idTracker.push(parseInt(data[i].iduser));
					console.log(idTracker);
					friElm += friCard;
				}

		}
		$('#userAppArea').append('<div id="friendViewHeader" class="row"><div class="col-md-8 col-md-offset-2">' +
								 '<h3>Friends</h3></div></div>');
		$('#userAppArea').append(friElm);
		idTracker = new Array();
}