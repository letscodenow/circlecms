<?php

require_once "app/models/users.php";

if (isUserLogged()) {
  header("Location: /dashboard/posts");
  exit();
}

echo template("dashboard/auth_form", array(
  "title" => "Sign in — Dashboard"
));
