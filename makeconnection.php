<?php
	
	if (isset($_POST['srid']) && isset($_POST['seid'])) {
		require_once('connectvars.php');
		$senderid = $_POST['srid'];
		$sendeeid = $_POST['seid'];
		$aFDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
		$chSrQuery = "SELECT idconnection FROM zn_connections WHERE sender=$senderid AND sendee=$sendeeid"; 
		$srResults = mysqli_query($aFDbc,$chSrQuery);
		$chSeQuery = "SELECT idconnection FROM zn_connections WHERE sendee=$senderid AND sender=$sendeeid";
		$seResults = mysqli_query($aFDbc,$chSeQuery);
		
		if(!mysqli_fetch_array($srResults) && !mysqli_fetch_array($seResults)) { 
			$aFQuery = "INSERT INTO zn_connections (sender,sendee,post_time,trueconn)" . " " . 
					   "VALUES ($senderid,$sendeeid,NOW(),0)";
			echo 'Request sent!';
			mysqli_query($aFDbc,$aFQuery);
		}
		else {
			echo "You already have a connection with this person!";
		}
		mysqli_close($aFDbc);
	}
	
?>