IF NOT EXISTS (SELECT * FROM sys.databases WHERE name='butkemp_pr_1')
	BEGIN
		CREATE DATABASE butkemp_pr_1
	END
	GO

USE [butkemp_pr_1]
GO

CREATE TABLE users(
	[id] int,
	[first_name] varchar(45) ,
	[last_name] varchar(45) ,
	[school] varchar(45) ,
	[address] varchar(45) ,
	[email] varchar(255) ,
	[phone_number] varchar(20) ,
	[location] varchar(45) ,
	[date_of_birth] DATE ,
	[gender] CHAR(1) ,
	CONSTRAINT usersPK PRIMARY KEY(id),
	CONSTRAINT usersGenderCheck CHECK(gender like 'L' or gender like 'W'),
)

CREATE TABLE pages(
	[id] int,
	[name] varchar(255),
	[content] varchar(255),
	CONSTRAINT pagesPK PRIMARY KEY(id),
)

CREATE TABLE page_likes(
	[id] int,
	[pages_id] int,
	[users_id] int,
	CONSTRAINT pageLikesPK PRIMARY KEY(id),
	CONSTRAINT pageLikesFKPage FOREIGN KEY(pages_id) REFERENCES pages(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pageLikesFKUser FOREIGN KEY(users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE friends(
	[id] int,
	[users_id] int,
	[friends_id] int,
	--[users_id_1] int,
	--[users_id_2] int,
	CONSTRAINT friendsPK PRIMARY KEY(id),
	CONSTRAINT friendsFKUser FOREIGN KEY(users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	--CONSTRAINT user1FK FOREIGN KEY(users_id_1) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	--CONSTRAINT user2FK FOREIGN KEY(users_id_2) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE posts(
	[id] int,
	[content] varchar(255),
	[date] DATE,
	[users_id] int,
	CONSTRAINT postsPK PRIMARY KEY(id),
	CONSTRAINT postFKUser FOREIGN KEY(users_id) REFERENCES users(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
)

CREATE TABLE post_shares(
	[id] int,
	[users_id] int,
	[posts_id] int,
	CONSTRAINT postSharesPK PRIMARY KEY(id),
	CONSTRAINT postSharesFKUser FOREIGN KEY(users_id) REFERENCES users(id) ON UPDATE SET NULL ON DELETE SET NULL,
	CONSTRAINT postSharesFKPost FOREIGN KEY(posts_id) REFERENCES posts(id) ON UPDATE SET NULL ON DELETE SET NULL,
)

CREATE TABLE post_comments(
	[id] int,
	[users_id] int,
	[posts_id] int,
	CONSTRAINT postCommentsPK PRIMARY KEY(id),
	CONSTRAINT postCommentsFKUser FOREIGN KEY(users_id) REFERENCES users(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT postCommentsFKPost FOREIGN KEY(posts_id) REFERENCES posts(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
)

CREATE TABLE comment_likes(
	[id] int,
	[users_id] int,
	[post_comments_id] int,
	CONSTRAINT commentLikesPK PRIMARY KEY(id),
	CONSTRAINT commentLikesFKUser FOREIGN KEY(users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT ccommentLikeFKPostCommend FOREIGN KEY(post_comments_id) REFERENCES post_comments(id) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE post_photos(
	[id] int,
	[image_content] varchar(255),
	[posts_id] int,
	CONSTRAINT postPhotosPK PRIMARY KEY(id),
	CONSTRAINT postPhotosFKPost FOREIGN KEY(posts_id) REFERENCES posts(id) ON UPDATE CASCADE ON DELETE CASCADE,
)
