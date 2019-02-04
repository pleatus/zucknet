<?php

	require_once('connectvars.php');
	
	if(isset($_GET['userPro'])) {
		$uid = $_GET['userPro'];
		//open dbc
		$uPDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
		//select user profile information
		$uPQuery = "SELECT fname,lname,city,tagline,photo_path FROM zn_users WHERE iduser=$uid";
		//echo $uPQuery;
		$uPResults = mysqli_query($uPDbc,$uPQuery);
		//select all posts made by user from userposts
		$uPPQuery = "SELECT idpost,contents,post_time FROM zn_posts INNER JOIN" . " " .
					"zn_userposts ON zn_userposts.idpost_posts = zn_posts.idpost" . " " .
					"WHERE zn_userposts.iduser_users=$uid ORDER BY zn_posts.post_time DESC LIMIT 10";
		//echo $uPPQuery;
		$uPPResults = mysqli_query($uPDbc,$uPPQuery);
		$rows = Array();
		while($r = mysqli_fetch_assoc($uPResults)) {
			$rows[] = $r;
		}
		while($r = mysqli_fetch_assoc($uPPResults)) {
			$rows[] = $r;
		}
		print json_encode($rows);
		mysqli_close($uPDbc);
		$rows = Array();
	}
	if(!empty($_POST['edPro'])){
		if($_POST['edPro'] == 'true') {
			if (!empty($_POST['uid'])){
				$uid = $_POST['uid'];
				$tagline = (!empty($_POST['tl'])) ? "tagline='" . $_POST['tl'] . "'" : null;
				$fname = (!empty($_POST['fn'])) ? "fname='" . $_POST['fn'] . "'" : null;
				$lname = (!empty($_POST['ln'])) ? "lname='" . $_POST['ln'] . "'" : null;
				$city = (!empty($_POST['cy'])) ? "city='" . $_POST['cy'] . "'" : null;
				//open dbc
				$edUpDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
				$edUpQuery = 'UPDATE zn_users SET' . ' ';
				$edUpPreQuery = Array();
				if ($tagline != null) {
					array_push($edUpPreQuery,$tagline);
				}
				if ($fname != null) {
					array_push($edUpPreQuery,$fname);
				}
				if ($lname != null) {
					array_push($edUpPreQuery,$lname);
				}
				if ($city != null) {
					array_push($edUpPreQuery,$city);
				}
				if(count($edUpPreQuery) > 0) {
					$parseQ = implode($edUpPreQuery,',');
					$edUpQuery .= $parseQ . ' ';
				}
				$edUpQuery .= "WHERE iduser=$uid LIMIT 1";
				mysqli_query($edUpDbc,$edUpQuery);
				mysqli_close($edUpDbc);
				$edUpPreQuery = Array();
			}
		}
	}
	if(!empty($_FILES['userProPic']['name'])) {
			require_once('jackin.php');
			if(0 < $_FILES['userProPic']['error']) {
				echo 'error setting pic ' . $_FILES['userProPic']['error'];
			}
			else {
				$newpicname = time() . '' . $_SESSION['userid'] . $_SESSION['usersname'] . 'zn' . $_FILES['userProPic']['name'];
				$source = $_FILES['userProPic']['tmp_name'];
				$target = 'userphotos/' . $newpicname;
				
				if(move_uploaded_file($source,$target)){
					$edPicDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
					$edPicQuery = 'UPDATE zn_users SET photo_path="' . $target .'" WHERE iduser=' . $_SESSION['userid'] . ' LIMIT 1';
					echo $edPicQuery;
					mysqli_query($edPicDbc,$edPicQuery);
					mysqli_close($edPicDbc);
				}
				else {
					echo 'error moving picture file to permanent storage';
				}
			}
	}

?>