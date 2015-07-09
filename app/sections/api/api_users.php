<?php

require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401, "json"));
}

if ($_SESSION["user"]["user_role"] !== "administrator") {
  exit(error(403, "json"));
}

$offset = (int)$_GET["offset"];
$limit = (int)$_GET["limit"];

$users = getUsers($offset, $limit);

if (count($users) === 0) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "Users not found"
    )
  ));
} else {
  json(array(
    "users" => $users
  ));
}
