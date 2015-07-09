<?php

require_once "app/models/posts.php";

$offset = (int)$_GET["offset"];
$limit = (int)$_GET["limit"];

$posts = getPosts($offset, $limit);

if (count($posts) === 0) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "Posts not found"
    )
  ));
} else {
  json(array(
    "offset" => $offset,
    "limit" => $limit,
    "posts" => $posts
  ));
}
