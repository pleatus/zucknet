<?php
	
	//start session
	session_start();
	$loggedin = false;
	
	//declare an empty string for error messages
	$er_mess = '';
	
	//if user isn't logged in try to log them in
	if(!isset($_SESSION['userid'])) {
		if(isset($_GET['jackin'])) {
			//declare dbc
			$dbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
			$userem = $_GET['email'];
			$uspass = sha1($_GET['password']);
			 
			if (!empty($userem) && !empty($uspass)) {
				$query = 'SELECT iduser,fname FROM zn_users WHERE email="' . $userem . '" AND uspassword="' . $uspass . '"';
				echo $query;
				$results = mysqli_query($dbc,$query);
				if(mysqli_num_rows($results) == 1) {
					echo 'found user record';
					//username and pass are correct and match a record
					$row = mysqli_fetch_array($results);
					//set session and cookie vars with query result
					$_SESSION['userid'] = $row['iduser'];
					$_SESSION['usersname'] = $row['fname'];
					setcookie('userid',$row['iduser'],(60*60*24*30)); //expires in 30 days
					setcookie('usersname',$row['fname'],(60*60*24*30)); //expirse in 30 days
					$usersname = $_SESSION['usersname'];
				}
				else {
					//there was no match for email and password, set error
					$er_mess = 'Jackin details are incorrect.';
				}
			}
			else {
				//one or both fields were empty, set error
				$er_mess = 'Jackin details are required.'; 
			}
			echo 'db: ' . DB_HOST . ', ' . DB_USER . ', ' . DB_PASS . ', ' . DB_NAME . ' em: ' . $userem.  ' p: ' . $uspass; 
		}
	}
	
	if(isset($_SESSION['userid'])) {
		$loggedin = true;
		//echo "<p>Your sess id is " . $_SESSION['userid'] . "</p>";
	}
	
	if(isset($_GET['jackout'])) {
		//if the user is logged in (they have to be to see this)
		if(isset($_SESSION['userid'])) {
			//clear the session var array
			$_SESSION = array();
			
			//clear the session cookie
			if(isset($_COOKIE[session_name()])) {
				setcookie(session_name(),'',time()-3600);
			}
			
			//clear the other cookies
			setcookie('userid','',time()-3600);
			setcookie('usersname','',time()-3600);
			
			//set header back to index
			//127.0.0.1/zn/
			$re_url = 'http://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']) . 'index.php';
			header('Location:',$re_url);
		}
	}

	if(!$loggedin) {
?>
<div class="col-md-3">
<form id="jackIn" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<label for="email">Email: <input type="email" name="email"></label>
<?php
	(!empty($er_mess)) ? $er_disp = '<h5 id="jackEr">' . $er_mess . '</h5>' : $er_disp = '';
	echo $er_disp;
?>
</div>
<div class="col-md-3">
<label for="password">Password: <input type="password" name="password"></label><br>
<input class="btn" id="jackInButton" type="submit" name="jackin" value="Jack In">
</form>
</div>
</div>
<?php
	}
if($loggedin) {
?>
<div class="col-md-3">
</div>
<div class="col-md-3">
<!--commented out code is for old jack out button displayed in usr bar at top, new jackout is in modal-->
<!--<form id="jackOut" method="GET" action="<?php //echo $_SERVER['PHP_SELF'] ?>">-->
<h5 id="greeting">Hello	<a href="" data-toggle="modal" data-target="#userMenu"><?php echo $_SESSION['usersname']; ?>! ˅</a></h5>
<!--<input class="btn" type="submit" name="jackout" value="Jack Out">
</form>-->
</div>
</div>

<div id="userMenu" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
		<h4 class="modal-title">What's up <?php echo $_SESSION['usersname']; ?>?</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <ul>
			<a href="" data-dismiss="modal" id="userMenuBeeps"><li>Beeps</li></a>
			<a href="" data-dismiss="modal" id="userMenuProfile"><li>Profile</li></a>
			<a href="" data-dismiss="modal" id="userMenuFind"><li>Find Zuckers</li></a>
			<a href="" data-dismiss="modal" id="userMenuJo"><li>Jack Out</li></a>
		</ul>
		<input id="userMenuId" type="hidden" value="<?php echo $_SESSION['userid']; ?>">
      </div>
      <div class="modal-footer">
      </div>
    </div>

  </div>
</div>

<?php
	}
	