CREATE TABLE zn_users (
	iduser	INT(16) NOT NULL AUTO_INCREMENT,
	uspassword	VARCHAR(50) NOT NULL,
	fname	VARCHAR(27) NOT NULL,
	lname	VARCHAR(45) NOT NULL,
	email	VARCHAR(60) NOT NULL,
	city	VARCHAR(54) NOT NULL,
	last_update	TIMESTAMP,
	join_time	TIMESTAMP,
	photo_path	VARCHAR(150),
	tagline	VARCHAR(160),
	PRIMARY KEY (iduser)
	);
CREATE TABLE zn_posts (
	idpost	INT(36) NOT NULL AUTO_INCREMENT,
	contents	VARCHAR(160) NOT NULL,
	post_time	TIMESTAMP,
	PRIMARY KEY (idpost)
	);
CREATE TABLE zn_userposts (
	iduserpost INT(36) NOT NULL AUTO_INCREMENT,
	idpost_posts	INT(36)	NOT NULL,
	iduser_users	INT(16)	NOT NULL,
	PRIMARY KEY (iduserpost),
	FOREIGN KEY (idpost_posts) REFERENCES zn_posts(idpost),
	FOREIGN KEY	(iduser_users) REFERENCES zn_users(iduser)
	);
CREATE TABLE zn_comments (
	idcomment	INT(36) NOT NULL AUTO_INCREMENT,
	contents	VARCHAR(160) NOT NULL,
	post_time	TIMESTAMP,
	PRIMARY KEY (idcomment)
	);
CREATE TABLE zn_usercomments (
	idusercomment	INT(36) NOT NULL AUTO_INCREMENT,
	iduser_users	INT(16)	NOT NULL,
	idcomment_comments	INT(36) NOT NULL,
	idpost_posts	INT(36)	NOT NULL,
	PRIMARY KEY (idusercomment),
	FOREIGN KEY (iduser_users) REFERENCES zn_users(iduser),
	FOREIGN KEY (idpost_posts) REFERENCES zn_posts(idpost),
	FOREIGN KEY (idcomment_comments) REFERENCES zn_comments(idcomment)
	);
CREATE TABLE zn_cools (
	idcool	INT(36) NOT NULL AUTO_INCREMENT,
	post_time	TIMESTAMP,
	PRIMARY KEY (idcool)
	);
CREATE TABLE zn_lames (
	idlame	INT(36) NOT NULL AUTO_INCREMENT,
	post_time	TIMESTAMP,
	PRIMARY KEY (idlame)
	);
CREATE TABLE zn_usercoolposts (
	iduser_users	INT(16) NOT NULL,
	idpost_posts	INT(36)	NOT NULL,
	idcool_cools	INT(36) NOT NULL,
	FOREIGN KEY (iduser_users) REFERENCES zn_users(iduser),
	FOREIGN KEY (idpost_posts) REFERENCES zn_posts(idpost),
	FOREIGN KEY (idcool_cools) REFERENCES zn_cools(idcool),
	PRIMARY KEY (iduser_users,idpost_posts,idcool_cools)
	);
CREATE TABLE zn_userlameposts (
	iduser_users	INT(16) NOT NULL,
	idpost_posts	INT(36)	NOT NULL,
	idlame_lames	INT(36) NOT NULL,
	FOREIGN KEY (iduser_users) REFERENCES zn_users(iduser),
	FOREIGN KEY (idpost_posts) REFERENCES zn_posts(idpost),
	FOREIGN KEY (idlame_lames) REFERENCES zn_lames(idlame),
	PRIMARY KEY (iduser_users,idpost_posts,idlame_lames)
	);
CREATE TABLE zn_connections	(
	idconnection	INT(36) NOT NULL AUTO_INCREMENT,
	sender	INT(16)	NOT NULL,
	sendee	INT(16)	NOT NULL,
	post_time	TIMESTAMP,
	trueconn	INT(1),
	PRIMARY KEY (idconnection)
	);
CREATE TABLE zn_userconnections (
	iduserconnection	INT(36)	NOT NULL AUTO_INCREMENT,
	idconn_conns	INT(36)	NOT NULL,
	PRIMARY KEY (iduserconnection),
	FOREIGN KEY (idconn_conns) REFERENCES zn_connections(idconnection)
	);
	
--working version of main feed query
SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_posts.idpost,zn_posts.contents,zn_posts.post_time
FROM zn_userconnections
INNER JOIN zn_connections ON zn_connections.idconnection = zn_userconnections.idconn_conns
INNER JOIN zn_users ON zn_users.iduser = zn_connections.sendee
INNER JOIN zn_userposts ON zn_userposts.iduser_users = zn_connections.sendee
INNER JOIN zn_posts ON zn_posts.idpost = zn_userposts.idpost_posts
WHERE zn_connections.sender = &uid
ORDER BY zn_posts.post_time LIMIT 15;
--query for main feed
SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_posts.idpost,zn_posts.contents
FROM zn_userposts
INNER JOIN zn_posts ON zn_posts.idpost = zn_userposts.idpost_posts
INNER JOIN zn_users ON zn_users.iduser = zn_userposts.iduser_users
--INNER JOIN zn_connections ON zn_connections.sender/sendee = zn_users.iduser
--INNER JOIN zn_userconnections ON zn_userconnections.idconn_conns = zn_connections.idconnection
WHERE zn_users.iduser = 
(SELECT sendee FROM zn_userconnections
INNER JOIN zn_connections ON zn_userconnections.idconn_conns = zn_connections.idconnection
INNER JOIN zn_users ON zn_users.iduser = zn_connections.sendee
WHERE  zn_connections.sender = &uid)
ORDER BY zn_posts.post_time LIMIT 15;
--different main feed query
SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.photo_path,zn_posts.idpost,zn_posts.contents
FROM zn_userconnections
INNER JOIN zn_connections ON zn_connections.idconnection = zn_userconnections.idconn_conns
INNER JOIN zn_users ON zn_users.iduser = zn_connections.sender
INNER JOIN zn_userposts ON zn_userposts.iduser_users = zn_connections.sendee
INNER JOIN zn_posts ON zn_posts.idpost = zn_userposts.idpost_posts
WHERE zn_connections.sender = 
ORDER BY zn_posts.post_time LIMIT 15;
--run a search on the users table by email
SELECT iduser,fname,lname,city,photo_path FROM zn_users WHERE email=&usersemail
--select all posts made by user from posts join userposts
SELECT contents FROM zn_posts INNER JOIN zn_userposts ON zn_userposts.idpost_posts = zn_posts.idpost WHERE zn_userposts.iduser_users=&uid ORDER BY zn_posts.post_time LIMIT 10;
--insert statement for new user
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Mark','Zuckerberg','mark@markymark.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Steve','Jobs','steve@comp.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Bill','Gates','bill@ms.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Oprah','Winfrey','opr@h.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Roseanne','Barr','rosie@barr.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Steve','Wozniack','steve@thewoz.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Richard','Stallman','rich@gnu.org','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Pussy','Galore','pajeet@xxx.com','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time) VALUES ('Beyonce','Knowles','yonce@me.be','Interbutt',NOW(),SHA1('password'));
INSERT INTO zn_users (fname,lname,email,city,join_time,uspassword) VALUES ('Pamela','Anderson','pig@gross.com','Interbutt',NOW(),SHA1('password'));
--update profile statements
UPDATE zn_users SET fname,lname,email,city,tagline,photo_path WHERE iduser=userid;
--update statement for users when action is made
UPDATE zn_users SET last_update=NOW() WHERE iduser=userid;
--create post statement
INSERT INTO zn_posts (contents,post_time) VALUES ('This is a test post!',NOW());
INSERT INTO zn_userposts (idpost_posts,iduser_users) VALUES ('1','1');
INSERT INTO zn_posts (contents,post_time) VALUES ('thinking about clandestine ways to get your data',NOW());
INSERT INTO zn_userposts (idpost_posts,iduser_users) VALUES ('2','1');
--create comment statement
INSERT INTO zn_comments (contents,post_time) VALUES ('This is a test comment!',NOW());
INSERT INTO zn_usercomments (idcomment_comments,iduser_users,idpost_posts) VALUES ('1','2','1');
--create a cool on a post
INSERT INTO zn_cools (post_time) VALUES (NOW());
INSERT INTO zn_usercoolposts (idcool_cools,idpost_posts,iduser_users) VALUES (idcool,idpost,iduser);
INSERT INTO zn_usercoolposts (idcool_cools,idpost_posts,iduser_users) VALUES ('1','1','2');
--create a lame on a post
INSERT INTO zn_lames (post_time) VALUES (NOW());
INSERT INTO zn_userlameposts (idlame_lames,idpost_posts,iduser_users) VALUES (idlame,idpost,iduser);
INSERT INTO zn_userlameposts (idlame_lames,idpost_posts,iduser_users) VALUES ('1','1','3');
--create a connection request
INSERT INTO zn_connections (sender,sendee,post_time,trueconn) VALUES ('1','2',NOW(),'0');
INSERT INTO zn_connections (sender,sendee,post_time,trueconn) VALUES ('3','1',NOW(),'0');
--request accepted set trueconn to 1
UPDATE zn_connections SET trueconn=1 WHERE sendee=SESSIONid AND sender=SENDERid;
--if trueconn == 1 create a user connection
INSERT INTO zn_userconnections (idconn_conns) VALUES (trueconn=1 CONNid);
--login query
SELECT iduser FROM zn_users WHERE email=steve@thewoz.com AND uspassword='5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8'
--friend page query
SELECT zn_users.iduser,zn_users.fname,zn_users.lname,zn_users.city,zn_users.photo_path,zn_connections.post_time
FROM zn_userconnections INNER JOIN zn_connections ON zn_connections.idconnection = zn_userconnections.idconn_conns
INNER JOIN zn_users ON zn_users.iduser = zn_connections.sendee WHERE zn_connections.sender = &uid;

--delete user query process
--delete comments
DELETE FROM zn_comments INNER JOIN zn_usercomments ON zn_usercomments.idcomment_comments = zn_comments.idcomment WHERE zn_usercomments.iduser_users = x;
DELETE * FROM zn_usercomments WHERE iduser_users = x;
