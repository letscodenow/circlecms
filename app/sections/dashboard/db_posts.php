<?php

require_once "app/models/posts.php";

$posts = getPosts(0, 10);

$posts_template = template("dashboard/posts", array(
  "posts" => $posts
));

echo template("dashboard/main", array(
  "title" => "Posts — Dashboard",
  "content" => $posts_template
));
