<?php

require_once "app/models/posts.php";
require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401, "json"));
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  exit(error(400, "json"));
}

$status = savePost($_POST["id"], $_POST["title"], $_POST["content_md"]);

if ($status === 1) {
  setResponseCode(400);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "The title and content have to be filled"
    )
  ));
} else if ($status === 2) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 2,
      "msg" => "The post doesn't exist"
    )
  ));
} else if ($status === false) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 3,
      "msg" => "The post hasn't been added"
    )
  ));
} else {
  json(array(
    "status" => true
  ));
}
