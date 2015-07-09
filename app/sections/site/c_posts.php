<?php

require_once "app/models/posts.php";

$posts = getPosts(0, 10);

$posts_template .= template("site/posts", array(
  "posts" => $posts
));

echo template("site/main", array(
  "title" => "Posts — Hubspace",
  "content" => $posts_template
));
