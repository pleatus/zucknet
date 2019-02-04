<?php
	
	if(isset($_GET['mainfeed'])) {
		require_once('connectvars.php');
		$mfDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
		$uid = $_GET['mainfeed'];
		$mFQuery1 = "SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_posts.idpost,zn_posts.contents,zn_posts.post_time
					FROM zn_userconnections
					INNER JOIN zn_connections ON zn_connections.idconnection = zn_userconnections.idconn_conns
					INNER JOIN zn_users ON zn_users.iduser = zn_connections.sendee
					INNER JOIN zn_userposts ON zn_userposts.iduser_users = zn_connections.sendee
					INNER JOIN zn_posts ON zn_posts.idpost = zn_userposts.idpost_posts
					WHERE zn_connections.sender = $uid AND zn_connections.trueconn=1
					ORDER BY zn_posts.post_time DESC LIMIT 15";
		$mFQuery2 = "SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_posts.idpost,zn_posts.contents,zn_posts.post_time
					FROM zn_userconnections
					INNER JOIN zn_connections ON zn_connections.idconnection = zn_userconnections.idconn_conns
					INNER JOIN zn_users ON zn_users.iduser = zn_connections.sender
					INNER JOIN zn_userposts ON zn_userposts.iduser_users = zn_connections.sender
					INNER JOIN zn_posts ON zn_posts.idpost = zn_userposts.idpost_posts
					WHERE zn_connections.sendee = $uid AND zn_connections.trueconn=1
					ORDER BY zn_posts.post_time DESC LIMIT 15";
		$mFQuery3 = "SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_posts.idpost,zn_posts.contents,zn_posts.post_time
					FROM zn_userposts
					INNER JOIN zn_posts ON zn_posts.idpost = zn_userposts.idpost_posts					
					INNER JOIN zn_users ON zn_users.iduser = zn_userposts.iduser_users
					WHERE zn_userposts.iduser_users=$uid
					ORDER BY zn_posts.post_time DESC LIMIT 15";
		$mFResults1 = mysqli_query($mfDbc,$mFQuery1);
		$mFResults2 = mysqli_query($mfDbc,$mFQuery2);
		$mFResults3 = mysqli_query($mfDbc,$mFQuery3);
		$results = Array();
		while($r = mysqli_fetch_assoc($mFResults1)) {
			$results[] = $r;
		}
		while($r = mysqli_fetch_assoc($mFResults2)) {
			$results[] = $r;
		}
		while($r = mysqli_fetch_assoc($mFResults3)) {
			$results[] = $r;
		}
		print json_encode($results);
		mysqli_close($mfDbc);
	}