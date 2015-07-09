<?php

if ($request === "/") {
  require_once "c_posts.php";
} else if (strpos($request, "/post/") === 0) {
  require_once "c_post.php";
} else {
  error(404);
}
