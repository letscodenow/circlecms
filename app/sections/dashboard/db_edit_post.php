<?php

require_once "app/models/posts.php";

preg_match("/\/post\/([0-9]+)/", $request, $id);
$id = (int)$id[1];

$post = getPostById($id);

if ($post === false) {
  exit(error(404));
}

$edit_template = template("dashboard/post_create", array(
  "post" => $post
));

echo template("dashboard/main", array(
  "title" => "Editing Post — Dashboard",
  "content" => $edit_template
));
