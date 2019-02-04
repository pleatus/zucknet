<!doctype html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="main.js"></script>
<link href="main.css" type="text/css" rel="stylesheet">
<title>Zucknet - <?php echo $pg_title ?></title>
</head>
<body>
<?php
	echo "<div id='userBar' class='fluid-container'>";
	echo "<div class='row'>";
	echo "<div class='col-md-6'>";
	echo "<h3><button id='znLogo'>Z<sub>N</sub> - " . $pg_title . "</button></h3>";
	echo "</div>";
	require_once('connectvars.php');
	require_once('jackin.php');
	echo "</div>";