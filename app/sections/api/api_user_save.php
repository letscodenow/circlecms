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

$status = saveUser(
  $_POST["id"],
  $_POST["username"],
  $_POST["name"],
  $_POST["email"],
  $_POST["password"],
  $_POST["role"]
);

if ($status === 1) {
  setResponseCode(400);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "The fields have to be filled"
    )
  ));
} else if ($status === 2) {
  setResponseCode(400);

  json(array(
    "error" => array(
      "code" => 2,
      "msg" => "The username is already taken"
    )
  ));
} else if ($status === 3) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 3,
      "msg" => "The user doesn't exist"
    )
  ));
} else if ($status === false) {
  setResponseCode(512);

  json(array(
    "error" => array(
      "code" => 4,
      "msg" => "Cannot add/update the data"
    )
  ));
} else {
  json(array(
    "status" => true
  ));
}
