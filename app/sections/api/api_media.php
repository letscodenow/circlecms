<?php

require_once "app/models/media.php";
require_once "app/models/users.php";

if (isUserLogged() === false) {
  exit(error(401, "json"));
}

$offset = (int)$_GET["offset"];
$limit = (int)$_GET["limit"];
$type = str_replace(" ", "", $_GET["type"]);

$media = getMedia($offset, $limit, $type);

if (count($media) === 0) {
  setResponseCode(404);

  json(array(
    "error" => array(
      "code" => 1,
      "msg" => "Media Not Found"
    )
  ));
} else {
  json(array(
    "media" => $media
  ));
}
