<?php

require_once "app/system/database.php";

function getMedia($offset, $limit, $type = "", $fields = array("media.*")) {
  $type = (string)$type;

  $offset = (int)$offset;
  $limit = (int)$limit;

  $fields = implode(",", $fields);
  $bind = array();

  if ($type !== "") {
    $where = "WHERE media.media_type = ?";
    $bind = array(array(1, $type));
  }

  $sql = "
    SELECT
      $fields,
      users.name AS author_name

    FROM
      media

    LEFT JOIN
      users
      ON users.id = media.author_id

    $where

    ORDER BY media.created_at DESC

    LIMIT $offset, $limit
  ";

  $db = Database::instance();
  $data = $db->query($sql)->bindAll($bind)->fetchAll();

  unset($db, $sql, $where, $bind);
  unset($fields, $offset, $limit, $type);

  return $data;
}

function getMediaById($id) {
  $id = (int)$id;
  $db = Database::instance();

  $sql = "SELECT * FROM media WHERE id = $id";
  $data = $db->query($sql)->fetch();

  unset($id, $db, $sql);

  return $data;
}

function getMediaByAuthor($author_id) {
  $author_id = (int)$author_id;
  $db = Database::instance();

  $sql = "SELECT * FROM media WHERE author_id = $author_id";
  $data = $db->query($sql)->fetchAll();

  unset($id, $db, $sql);

  return $data;
}

function deleteMediaFile($media_file) {
  $filepath = ROOT_DIR . "uploads/";
  $filepath .= pathinfo($media_file, PATHINFO_BASENAME);

  if (file_exists($filepath) && is_dir($filepath) === false) {
    unlink($filepath);

    if (file_exists($filepath)) {
      return false;
    }
  }

  return true;
}

function deleteMedia($id) {
  $id = (int)$id;
  $media = getMediaById($id);

  if ($media === false) {
    return 1;
  }

  if (deleteMediaFile($media["media_file"]) === false) {
    return 2;
  }

  $db = Database::instance();
  $status = $db->query("DELETE FROM media WHERE id = $id")->execute();

  unset($media, $filepath, $db, $id);
  return $status;
}

function deleteMediaByAuthor($author_id) {
  $author_id = (int)$author_id;
  $media = getMediaByAuthor($author_id);

  $db = Database::instance();

  foreach ($media as $one) {
    $status = $db->query("DELETE FROM media WHERE id = {$one["id"]}")->execute();

    if ($status === false) {
      return false;
    }

    $status = deleteMediaFile($one["media_file"]);

    if ($status === false) {
      return false;
    }
  }

  return true;
}

function addMedia($file) {
  if ($file === null || $file["error"] === UPLOAD_ERR_NO_FILE) {
    return 1;
  }

  if ($file["error"] != UPLOAD_ERR_OK) {
    return 2;
  }

  $author_id = (int)$_SESSION["user"]["user_id"];
  $media_name = $file["name"];

  $tmp_path = $file["tmp_name"];

  $file_ext = pathinfo($media_name, PATHINFO_EXTENSION);
  $media_file = "uploads/" . md5($file_name . time()) . "." . $file_ext;

  // For the moment, allow only images to be uploaded.
  if (@!is_array(getimagesize($tmp_path))) {
    return 3;
  }

  if (move_uploaded_file($tmp_path, $media_file) === false) {
    return 4;
  }

  $sql = "
    INSERT INTO media (
      media_name,
      media_file,
      media_type,
      author_id
    ) VALUES (
      ?, ?, ?, ?
    )
  ";

  $status = Database::instance()->query($sql)->bindAll(array(
    array(1, $media_name),
    array(2, "/" . $media_file),
    array(3, "image"),
    array(4, (int)$author_id)
  ))->execute();

  if ($status === false) {
    @unlink($media_file);
  }

  unset($sql, $media_name, $media_file, $author_id);
  unset($tmp_path, $file_ext, $file);

  return $status;
}
