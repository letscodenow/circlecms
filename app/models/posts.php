<?php

require_once "app/system/database.php";
require_once "app/system/parsedown.php";

function getPosts($offset, $limit, $fields = array("posts.*")) {
  $db = Database::instance();

  $offset = (int)$offset;
  $limit = (int)$limit;

  if (in_array("posts.*", $fields) || in_array("posts.content_html", $fields)) {
    $enable_preview = true;
  }

  $fields = implode(", ", $fields);

  $data = $db->query("
    SELECT
      $fields,
      users.name AS author_name

    FROM posts

    LEFT JOIN
      users
      ON posts.author_id = users.id

    WHERE posts.status <> '0'

    ORDER BY posts.created_at DESC

    LIMIT $offset, $limit
  ")->fetchAll();

  if ($enable_preview) {
    for ($i = 0, $len = count($data); $i < $len; $i++) {
      $data[$i]["preview_html"] = explode("[{cut}]", $data[$i]["content_html"])[0];
    }
  }

  return $data;
}

function getPostById($id, $fields = array("posts.*")) {
  $id = (int)$id;
  $db = Database::instance();

  $fields = implode(", ", $fields);

  $data = $db->query("
    SELECT
      $fields,
      users.name AS author_name

    FROM posts

    LEFT JOIN
      users
      ON posts.author_id = users.id

    WHERE posts.id = ? AND posts.status <> '0'
  ")->bind(1, $id)->fetch();

  if ($data) {
    $data["content_html"] = str_replace("[{cut}]", "", $data["content_html"]);
  }

  return $data;
}

function savePost($id, $title, $content_md) {
  $id = (int)$id;
  $title = trim((string)$title);

  $content_md = trim((string)$content_md);
  $content_html = Parsedown::instance()->text($content_md);

  $author_id = (int)$_SESSION["user"]["user_id"];

  if ($title === "" || $content_md === "") {
    return 1;
  }

  $db = Database::instance();

  if ($id === 0) {
    $sql = "
      INSERT INTO posts (
        title, content_md,
        content_html, author_id
      ) VALUES(?, ?, ?, ?)
    ";

    $bind = array(
      array(1, $title),
      array(2, $content_md),
      array(3, $content_html),
      array(4, $author_id)
    );
  } else {
    $post = getPostById($id);

    if ($post === false || $post["status"] === "0") {
      return 2;
    }

    if ($post["content_md"] === $content_md &&
        $post["content_html"] === $content_html &&
        $post["title"] === $title) {
      return true;
    }

    $sql = "
      UPDATE
        posts
      SET
        title = ?,
        content_md = ?,
        content_html = ?
      WHERE
        id = $id
    ";

    $bind = array(
      array(1, $title),
      array(2, $content_md),
      array(3, $content_html),
    );
  }

  return $db->query($sql)->bindAll($bind)->execute();
}

function deletePost($id) {
  $id = (int)$id;
  $post = getPostById($id);

  if ($post === false) {
    return 1;
  }

  $db = Database::instance();
  $sql = "UPDATE posts SET status = '0' WHERE id = $id";

  return $db->query($sql)->execute();
}

function deletePostByAuthor($author_id) {
  $author_id = (int)$author_id;

  $db = Database::instance();
  $sql = "UPDATE posts SET status = '0' WHERE author_id = $author_id";

  return $db->query($sql)->execute();
}

function setPostLike($id, $num) {
  $id = (int)$id;
  $num = (int)$num;

  $post = getPostById($id, array("posts.id"));

  if ($post === false) {
    return 1;
  }

  $db = Database::instance();
  $sql = "UPDATE posts SET likes = likes + $num WHERE id = $id";

  try {
    return $db->query($sql)->execute();
  } catch (PDOException $e) {
    return $e->getCode();
  }
}
