<?php

require_once "app/models/media.php";
require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401, "json"));
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  exit(error(400, "json"));
}

$id = (int)$_POST["id"];

$status = deleteMedia($id);

if ($status === 1) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "The element doesn't exist"
    )
  ));
} else if ($status === 2) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 2,
      "msg" => "The file cannot be deleted at the moment"
    )
  ));
} else if ($status === false) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 3,
      "msg" => "The element cannot be deleted"
    )
  ));
} else {
  json(array(
    "status" => true
  ));
}
