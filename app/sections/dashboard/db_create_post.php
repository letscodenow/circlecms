<?php

$edit_template = template("dashboard/post_create");

echo template("dashboard/main", array(
  "title" => "New Post — Dashboard",
  "content" => $edit_template
));
