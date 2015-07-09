<?php

require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401, "json"));
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  exit(error(400, "json"));
}

if ($_SESSION["user"]["user_role"] !== "administrator") {
  exit(error(403, "json"));
}

$id = (int)$_POST["id"];

$status = deleteUser($id);

if ($status === 1) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "The user doesn't exist"
    )
  ));
} else if ($status === 2) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 2,
      "msg" => "Cannot delete all data of user. Aborted"
    )
  ));
} else if ($status === false) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 3,
      "msg" => "Cannot delete the entry of the user"
    )
  ));
} else {
  json(array(
    "status" => true
  ));
}
