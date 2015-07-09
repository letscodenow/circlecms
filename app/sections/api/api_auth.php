<?php

require_once "app/models/users.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  exit(error(400, "json"));
}

$auth = authorizeUser($_POST["username"], $_POST["password"]);

if ($auth === 1) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "User not found"
    )
  ));
} else if ($auth === 2) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 2,
      "msg" => "The user password doesn't match"
    )
  ));
} else {
  json(array(
    "status" => true
  ));
}
