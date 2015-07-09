<?php

require_once "app/models/media.php";
require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401));
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $file = $_FILES["media-file"];
  $status = addMedia($file);

  if ($status === 1) {
    $add_error = "You didn't upload the file.";
  } else if ($status === 2 || $status === 4 || $status === false) {
    $add_error = "The file hasn't been uploaded. Please, try later.";
  } else if ($status === 3) {
    $add_error = "You can upload only images.";
  }
}

$media = getMedia(0, 10);

$media_template = template("dashboard/media", array(
  "media" => $media,
  "add_error" => $add_error
));

echo template("dashboard/main", array(
  "title" => "Media — Dashboard",
  "content" => $media_template
));
