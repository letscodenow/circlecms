<?php

$create_template = template("dashboard/user_create");

echo template("dashboard/main", array(
  "title" => "New User — Dashboard",
  "content" => $create_template
));
