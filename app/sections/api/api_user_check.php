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

$status = doesUsernameExist($_POST["username"]);

if (!$status) {
  setResponseCode(404);
}

json(array(
  "status" => $status
));
