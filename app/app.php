<?php

require_once "models/functions.php";
require_once "models/users.php";

if (isUserLogged() && !doesUserExist($_SESSION["user"]["user_id"])) {
  $_SESSION["user"] = null;
}

if (strpos($request, "/api") === 0) {
  ini_set("html_errors", "Off");
  require_once "sections/api/routes.php";
} else if (strpos($request, "/dashboard") === 0) {
  require_once "sections/dashboard/routes.php";
} else {
  require_once "sections/site/routes.php";
}
