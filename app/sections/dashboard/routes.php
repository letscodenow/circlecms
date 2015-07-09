<?php

require_once "app/models/users.php";

if ($request !== "/dashboard" && isUserLogged() === false) {
  exit(error(401));
}

if ($request === "/dashboard") {
  require_once "db_auth.php";
} else if ($request === "/dashboard/signout") {
  require_once "db_signout.php";
} else if ($request === "/dashboard/posts") {
  require_once "db_posts.php";
} else if ($request === "/dashboard/post/new") {
  require_once "db_create_post.php";
} else if (strpos($request, "/dashboard/post/") === 0) {
  require_once "db_edit_post.php";
} else if ($request === "/dashboard/media") {
  require_once "db_media.php";
} else if ($request === "/dashboard/users") {
  require_once "db_users.php";
} else if ($request === "/dashboard/user/add") {
  require_once "db_user_add.php";
} else if (strpos($request, "/dashboard/user/") === 0) {
  require_once "db_user_edit.php";
} else {
  error(404);
}
