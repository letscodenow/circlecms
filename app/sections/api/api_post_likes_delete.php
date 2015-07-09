<?php

require_once "app/models/posts.php";

$id = (int)$_GET["id"];
$status = setPostLike($id, -1);

if ($status === 1) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "The post doesn't exist"
    )
  ));
} else if ($status === false) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 2,
      "msg" => "The like hasn't been deleted"
    )
  ));
} else {
  json(array(
    "status" => true
  ));
}
