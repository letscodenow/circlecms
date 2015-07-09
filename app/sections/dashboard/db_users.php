<?php

require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401));
}

if ($_SESSION["user"]["user_role"] !== "administrator") {
  exit(error(403));
}

$users = getUsers(0, 10);

$users_template = template("dashboard/users", array(
  "users" => $users
));

echo template("dashboard/main", array(
  "title" => "Users — Dashboard",
  "content" => $users_template
));
