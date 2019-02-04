<?php
	
	require_once('connectvars.php');
	$bDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
	
	if(isset($_GET['beepget'])){
		$uid = $_GET['uid'];
		//$frQuery = "SELECT zn_connections.sender FROM zn_connections WHERE sendee=$uid AND trueconn=0";
		$frQuery = "SELECT zn_connections.sender,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_users.city,zn_users.iduser
					FROM zn_connections
					INNER JOIN zn_users ON zn_users.iduser = zn_connections.sender
					WHERE sendee=$uid AND trueconn=0";
		$frResults = mysqli_query($bDbc,$frQuery);
		
		$frRequests = Array();
		while($fr = mysqli_fetch_assoc($frResults)) {
			$frRequests[] = $fr;
		}
		print json_encode($frRequests);
		
		/*$cmQuery = "SELECT zn_comments.idcomment,zn_usercomments.iduser_users FROM zn_userposts
					INNER JOIN zn_usercomments ON zn_usercomments.idpost_posts = zn_userposts.idpost_posts
					INNER JOIN zn_comments ON zn_comments.idcomment = zn_usercomments.idcomment_comments
					WHERE zn_userposts.iduser_users=$uid";
		$clQuery = "SELECT zn_cools.idcool,zn_usercoolposts.iduser_users FROM zn_userposts
					INNER JOIN zn_usercoolposts ON zn_usercoolposts.idpost_posts = zn_userposts.idpost_posts
					INNER JOIN zn_cools ON zn_cools.idcool = zn_usercoolposts.idcool_cools
					WHERE zn_userposts.iduser_users=$uid";
		$lmQuery = "SELECT zn_lames.idlame,zn_userlameposts.iduser_users FROM zn_userposts
					INNER JOIN zn_userlameposts ON zn_userlameposts.idpost_posts = zn_userposts.idpost_posts
					INNER JOIN zn_lames ON zn_lames.idlame = zn_userlameposts.idlame_lames
					WHERE zn_userposts.iduser_users=$uid";*/
	}
	
	mysqli_close($bDbc);
	/*SELECT zn_comments.idcomment,zn_usercomments.iduser_users FROM zn_userposts
	INNER JOIN zn_usercomments ON zn_usercomments.idpost_posts = zn_userposts.idpost_posts
	INNER JOIN zn_comments ON zn_comments.idcomment = zn_usercomments.idcomment_comments
	WHERE zn_userposts.idpost_posts = 1*/