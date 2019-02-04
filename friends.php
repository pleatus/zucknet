<?php
	require_once('connectvars.php');
	//set dbc
	$fDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
	
	if(isset($_GET['uid'])){
		
		$uid = $_GET['uid'];
		
		$fQuery = "SELECT zn_users.iduser,zn_users.tagline,zn_users.fname,zn_users.lname,zn_users.city," . " " .
				  "zn_users.photo_path,zn_connections.post_time FROM zn_userconnections" . " " .
				  "INNER JOIN zn_connections ON zn_connections.idconnection =" . " " .
				  "zn_userconnections.idconn_conns INNER JOIN zn_users ON" . " " .
				  "zn_users.iduser = zn_connections.sendee WHERE zn_connections.sender = $uid";
		$f2Query = "SELECT zn_users.iduser,zn_users.tagline,zn_users.fname,zn_users.lname,zn_users.city," . " " .
				  "zn_users.photo_path,zn_connections.post_time FROM zn_userconnections" . " " .
				  "INNER JOIN zn_connections ON zn_connections.idconnection =" . " " .
				  "zn_userconnections.idconn_conns INNER JOIN zn_users ON" . " " .
				  "zn_users.iduser = zn_connections.sender WHERE zn_connections.sendee = $uid";
		$fResults = mysqli_query($fDbc,$fQuery);
		$f2Results = mysqli_query($fDbc,$f2Query);
		$rows = Array();
		while($f = mysqli_fetch_assoc($fResults)) {
			$rows[] = $f;
		}
		while($f = mysqli_fetch_assoc($f2Results)) {
			$rows[] = $f;
		}
		//echo $fQuery;
		print json_encode($rows);
	}
	
	if(isset($_POST['fa'])) {
		$actioncode = substr($_POST['fa'],0,2);
		$uid = $_POST['uid'];
		$fid = substr($_POST['fa'],2);
		echo 'action is ' . $actioncode . '. fid is ' . $fid . '.';
		if($actioncode == 'af') {
			//request accepted, add friend (set trueconn to 1 and create userconnection)
			$afQuery = "UPDATE zn_connections SET trueconn=1,idconnection=LAST_INSERT_ID(idconnection) WHERE sendee=$uid AND sender=$fid";
			$afQuery2 = "INSERT INTO zn_userconnections (idconn_conns) VALUES (last_insert_id())";
			//echo $afQuery;
			mysqli_query($fDbc,$afQuery);
			mysqli_query($fDbc,$afQuery2);
			echo "Friend request approved!";
		}
		if($actioncode == 'df') {
			//request denied, deny friend (set trueconn to 2 and create userconnection)
			$afQuery = "UPDATE zn_connections SET trueconn=9,idconnection=LAST_INSERT_ID(idconnection) WHERE sendee=$uid AND sender=$fid";
			$afQuery2 = "INSERT INTO zn_userconnections (idconn_conns) VALUES (last_insert_id())";
			//echo $afQuery;
			mysqli_query($fDbc,$afQuery);
			mysqli_query($fDbc,$afQuery2);
			echo "Friend request denied.";
		}
		if($actioncode == 'rf') {
			//friend removed, remove friend (set trueconn to 9 and remove userconnection)
			$afQuery = "UPDATE zn_connections SET trueconn=1 WHERE sendee=$uid AND sender=$fid";
			echo $afQuery;
		}
	}
	
	mysqli_close($fDbc);
?>