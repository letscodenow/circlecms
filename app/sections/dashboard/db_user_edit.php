<?php

require_once "app/models/users.php";

preg_match("/\/dashboard\/user\/([0-9]+)/", $request, $id);
$id = (int)$id[1];

$user = getUserById($id);

if ($post === false) {
  exit(error(404));
}

$create_template = template("dashboard/user_create", array(
  "user" => $user
));

echo template("dashboard/main", array(
  "title" => "Editing user — Dashboard",
  "content" => $create_template
));
