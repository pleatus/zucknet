<?php
	$pg_title = 'The Zucccening!';
	require_once('header.php');
	
	$signup_output = '';
	
	if(isset($_POST['zuckme'])) {
		$fname = $_POST['firstname'];
		$lname = $_POST['lastname'];
		$email = $_POST['email'];
		$city = $_POST['city'];
		$password0 = $_POST['signuppass0'];
		$password1 = $_POST['signuppass1'];
		
		if($password0 == $password1) {
			$password = sha1($password0);
			$sQuery = "INSERT INTO zn_users (fname,lname,email,city,join_time,uspassword) VALUES ('$fname','$lname','$email','$city',now(),'$password')";
			$sDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
			mysqli_query($sDbc,$sQuery);
			$signup_output = 'Welcome to the net ' . $fname . '!';
		}
		else {
			$signup_output = 'Passwords do not match!';
		}
		mysqli_close($sDbc);
	}
	
	if($loggedin)	{
		echo'<main class="fluid-container">';
		if(isset($_POST['postUp'])) {
			$upDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
			if(!empty($_POST['postcontents'])) {
				$id = $_SESSION['userid'];
				$user_post = $_POST['postcontents'];
				$pQuery = "INSERT INTO zn_posts (contents,post_time) VALUES ('$user_post',NOW())";
				$upQuery = "INSERT INTO zn_userposts (idpost_posts,iduser_users) VALUES (LAST_INSERT_ID(),$id)";
				//echo $pQuery;
				//echo $upQuery;
				mysqli_query($upDbc,$pQuery);
				mysqli_query($upDbc,$upQuery);
				$post_status = 'Successfully posted!';
			}
			else {
				$post_status = 'No contents! NO posted! >.<';
			}
			mysqli_close($upDbc);
		}
		
		//echo '<h3>Hello World!</h3>';
		echo "<div id='mainInputContainer' class='row'>";
		echo "<div class='col-md-4'></div>";
		echo '<div id="userpostbox" class="col-md-4">';
		echo '<form name="userpost" method="POST" action="">';
		echo '<label for="postcontents">' . $_SESSION['usersname'] . ' is ';
		echo '<input id="postcontents" name="postcontents" type="text"></label>';
		echo '<input class="btn" type="submit" value="Post!" name="postUp">';
		echo '</form>';
		echo (!empty($post_status)) ? '<h6 id="postStatus">' . $post_status . '</h6>' : ''; 
		echo '</div>';
		echo "<div class='col-md-4'></div>";
		echo '</div>';
	}
	echo "<div id='userAppArea' class='fluid-container'>";
	echo "</div>";
	echo '</main>';
	
	if(!$loggedin) {
?>
	<div id="usersignup" class="fluid-container">
	<h4>Sign up for Zucknet!</h4>
	<h6>The <strong>NEW</strong> <em>original</em> social network</h6>
	<form name="signup" method="POST" action="">
	<label for="firstname" class="usersignup">First name: <input class="usersignup" name="firstname" type="text"></label><br>
	<label for="lastname" class="usersignup">Last name: <input class="usersignup" name="lastname" type="text"></label><br>
	<label for="email" class="usersignup">Email: <input class="usersignup" name="email" type="email"></label><br>
	<label for="city" class="usersignup">City: <input class="usersignup" name="city" type="text"></label><br>
	<label for="signuppass0" class="usersignup">Password: <input class="usersignup" name="signuppass0" type="password"></label><br>
	<label for="signuppass1" class="usersignup">Confirm Password: <input class="usersignup" name="signuppass1" type="password"></label><br>
	<input name="zuckme" type="submit" value="Sign up" class="usersignup btn">
	</form>
	<?php echo (!empty($signup_output)) ? '<h6 id="sigupOut">' . $signup_output . '</h6>' : ''; ?> 
	</div>
<?php
	}
?>
</body>
</html>