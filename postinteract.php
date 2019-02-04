<?php
	
	require_once('connectvars.php');
	$pIDbc = mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
	
	if(isset($_POST['interact'])) {
		
		$uid = $_POST['uid'];
		$interaction_code = substr($_POST['interact'],0,2);
		$postid = substr($_POST['interact'],2);
		//query to see if the interaction exists already
		$cpQuery1 = "SELECT iduser_users,idpost_posts FROM zn_usercoolposts WHERE iduser_users=$uid AND idpost_posts=$postid";
		$cpResults = mysqli_query($pIDbc,$cpQuery1);
		$lpQuery1 = "SELECT iduser_users,idpost_posts FROM zn_userlameposts WHERE iduser_users=$uid AND idpost_posts=$postid";
		$lpResults = mysqli_query($pIDbc,$lpQuery1);
		
		if(!mysqli_fetch_array($cpResults) && !mysqli_fetch_array($lpResults)) {
			if($interaction_code == 'cp') {
				
					$cpQuery1 = "INSERT INTO zn_cools (post_time) VALUES (NOW())";
					$cpQuery2 = "INSERT INTO zn_usercoolposts (iduser_users,idpost_posts,idcool_cools)
								 VALUES ($uid,$postid,last_insert_id())";
					mysqli_query($pIDbc,$cpQuery1);
					mysqli_query($pIDbc,$cpQuery2);

			}
			if($interaction_code == 'lp') {

					$lpQuery1 = "INSERT INTO zn_lames (post_time) VALUES (now())";
					$lpQuery2 = "INSERT INTO zn_userlameposts (iduser_users,idpost_posts,idlame_lames)
								 VALUES ($uid,$postid,LAST_INSERT_ID())";
					mysqli_query($pIDbc,$lpQuery1);
					mysqli_query($pIDbc,$lpQuery2);

			}
		}
		else {
			echo "You've already made your decision. No takesies backsies.";
		}
		

	}
	
	if(isset($_GET['comment'])){
		$postid = substr($_GET['comment'],2);
		//echo $postid;
		$cmQuery = "SELECT zn_comments.idcomment,zn_comments.contents,zn_comments.post_time,zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path
					FROM zn_usercomments INNER JOIN zn_users ON zn_users.iduser = zn_usercomments.iduser_users
					INNER JOIN zn_comments ON zn_comments.idcomment = zn_usercomments.idcomment_comments
					WHERE zn_usercomments.idpost_posts = $postid ORDER BY zn_comments.post_time DESC LIMIT 20";
		//echo $cmQuery;
		$cmResults = mysqli_query($pIDbc,$cmQuery);
		
		$comres = Array();
			
		while($cm = mysqli_fetch_assoc($cmResults)) {
			//echo 'the loop is ' . $looptrack;
			$comres[] = $cm;
		}
		echo json_encode($comres);
		
	}
	
	if(isset($_POST['postCom'])){
		if($_POST['postCom'] == 1){
			$pid = substr($_POST['pid'],2);
			$uid = $_POST['uid'];
			$com = $_POST['com'];
			$pcmQuery1 = "INSERT INTO zn_comments (contents,post_time) VALUES ('$com',now())";
			$pcmQuery2 = "INSERT INTO zn_usercomments (iduser_users,idcomment_comments,idpost_posts) VALUES ($uid,last_insert_id(),$pid)";
			//echo $pcmQuery1;
			//echo $pcmQuery2;
			mysqli_query($pIDbc,$pcmQuery1);
			mysqli_query($pIDbc,$pcmQuery2);
			echo "Comment succesfully posted!";
		}
		else {
			echo "Something went terribly wrong.";
		}
	}
	
	mysqli_close($pIDbc);