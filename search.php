<?php

	if(isset($_GET['search'])) {
		require_once('connectvars.php');
		$searchterms = $_GET['search'];
		//put in some preprocessing for the search term here, but for now let's query by email only
		$sDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
		$sQuery = "SELECT iduser,fname,lname,city,photo_path FROM zn_users WHERE email='$searchterms'";
		$sResults = mysqli_query($sDbc,$sQuery);
		$rows = Array();
		while($s = mysqli_fetch_assoc($sResults)) {
			$rows[] = $s;
		}
		print json_encode($rows);
	}
	
?>