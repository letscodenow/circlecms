<?php

require_once "app/models/posts.php";

preg_match("/\/post\/([0-9]+)/", $request, $id);
$id = (int)$id[1];

$post = getPostById($id);

if ($post === false) {
  error("404");
  exit;
}

$post_template .= template("site/post", array(
  "post" => $post
));

echo template("site/main", array(
  "title" => "{$post["title"]} — Hubspace",
  "content" => $post_template
));
