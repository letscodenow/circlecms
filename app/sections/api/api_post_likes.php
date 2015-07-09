<?php

require_once "app/models/posts.php";

$id = (int)$_GET["id"];
$post = getPostById($id, array("posts.likes"));

if ($post === false) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "The post doesn't exist"
    )
  ));
} else {
  json(array(
    "post" => array(
      "id" => $id,
      "likes" => (int)$post["likes"]
    )
  ));
}
