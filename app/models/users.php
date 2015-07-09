<?php

require_once "app/system/database.php";
require_once "app/models/posts.php";
require_once "app/models/media.php";

function getUsers($offset, $limit) {
  $offset = (int)$offset;
  $limit = (int)$limit;

  $data = Database::instance()->query("
    SELECT *
    FROM users
    WHERE status <> '0'
    LIMIT $offset, $limit
  ")->fetchAll();

  unset($offset, $limit, $sql);
  return $data;
}

function getUserById($id) {
  $db = Database::instance();
  $id = (int)$id;

  $sql = "SELECT * FROM users WHERE id = $id AND status <> '0'";
  $data = $db->query($sql)->fetch();

  unset($db, $id, $sql);

  return $data;
}

function getUserByUsername($username) {
  $db = Database::instance();
  $username = (string)$username;

  $sql = "SELECT * FROM users WHERE username = ? AND status <> '0'";
  $data = $db->query($sql)->bind(1, $username)->fetch();

  return $data;
}

function saveUser($id, $username, $name, $email, $password, $role) {
  $id = (int)$id;
  $name = (string)$name;
  $username = str_replace(" ", "", (string)$username);

  $password = (string)$password;
  $hashed_password = generatePassword($password);

  $role = (string)$role === "administrator" ? "administrator" : "editor";

  if ($name === "" || $username === "" || ($id === 0 && $password === "")) {
    return 1;
  }

  if ($id === 0 && doesUsernameExist($username)) {
    return 2;
  }

  if ($id === 0) {
    $sql = "
      INSERT INTO users (
        username, name, email, password, role 
      ) VALUES(
        ?, ?, ?, ?, ?
      )
    ";
  } else {
    $user = getUserById($id);

    if ($user === false) {
      return 3;
    }

    if ($password === "") {
      $hashed_password = $user["password"];
    }

    if ($user["username"] === $username && $user["name"] === $name &&
        $user["email"] === $email && $user["password"] === $hashed_password &&
        $user["role"] === $role) {
      return true;
    }

    $sql = "
      UPDATE
        users
      SET
        username = ?,
        name = ?,
        email = ?,
        password = ?,
        role = ?
      WHERE
        id = $id
    ";
  }

  $status = Database::instance()->query($sql)->bindAll(array(
    array(1, $username),
    array(2, $name),
    array(3, $email),
    array(4, $hashed_password),
    array(5, $role)
  ))->execute();

  unset($username, $name, $email, $hashed_password, $role, $sql);

  return $status;
}

function deleteUser($id) {
  $id = (int)$id;
  $user = getUserById($id);

  if ($user === false) {
    return 1;
  }

  // Delete all posts
  $status = deletePostByAuthor($id);

  if ($status === false) {
    return 2;
  }

  // Delete all media
  $status = deleteMediaByAuthor($id);

  if ($status === false) {
    return 2;
  }

  // Delete the user
  $sql = "UPDATE users SET status = '0' WHERE id = $id";
  $status = Database::instance()->query($sql)->execute();

  unset($id, $user, $sql);
  return $status;
}

function isUserLogged() {
  return $_SESSION["user"]["logged"] === true;
}

function authorizeUser($username, $password) {
  $username = (string)$username;
  $password = (string)$password;

  $user = getUserByUsername($username);

  if ($user === false || $user["status"] === "0") {
    return 1;
  }

  $hashed_password = generatePassword($password);

  if ($user["password"] !== $hashed_password) {
    return 2;
  }

  $_SESSION["user"] = array(
    "logged" => true,
    "logged_time" => time(),

    "user_id" => (int)$user["id"],
    "username" => $user["username"],
    "user_role" => $user["role"]
  );

  return true;
}

function generatePassword($password) {
  return md5("jUS}{*&@." . sha1(")@K" . $password . "##AD#") . ")K@~~@@@!P!");
}

function doesUserExist($id) {
  $id = (int)$id;

  $sql = "SELECT id FROM users WHERE id = $id AND status <> '0'";
  $status = Database::instance()->query($sql)->fetch();

  unset($id, $sql);
  return (bool)$status["id"];
}

function doesUsernameExist($username) {
  $username = str_replace(" ", "", (string)$username);

  $sql = "SELECT id FROM users WHERE username = ?";
  $status = Database::instance()->query($sql)->bind(1, $username)->fetch();

  unset($id, $sql);
  return (bool)$status["id"];
}
