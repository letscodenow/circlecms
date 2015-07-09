<?php

class Database {
  private $dbh;
  private $error;
  private $stmt;

  private static $_instance;
  private static $_instance_db;

  public static function instance($db = "main") {
    if (is_null(static::$_instance) || static::$_instance_db != $db) {
      static::$_instance = new static($db);
      static::$_instance_db = $db;
    }

    return static::$_instance;
  }

  public function __construct($db = "main") {
    $settings = json_decode(file_get_contents(ROOT_DIR . "/app/configs/dbconfig.json"));

    // Set DSN
    $dsn = sprintf(
      $settings->$db->dsn,
      $settings->$db->host,
      $settings->$db->dbname,
      $settings->$db->charset
    );

    // Set options
    $options = array(
      PDO::ATTR_PERSISTENT    => false,
      PDO::ATTR_ERRMODE       => PDO::ERRMODE_EXCEPTION
    );

    try {
      $this->dbh = new PDO(
        $dsn,
        $settings->$db->user,
        $settings->$db->password,
        $options
      );
    } catch(\PDOException $e) {
      $this->error = $e->getMessage();
    }
  }

  public function __destruct() {
    $this->dbh = null;
  }

  public function query($query) {
    $this->stmt = $this->dbh->prepare($query);
    return $this;
  }

  public function bind($param, $value, $type = null) {
    if (is_null($type)) {
      switch (true) {
        case is_int($value):
          $type = PDO::PARAM_INT;
          break;
        case is_bool($value):
          $type = PDO::PARAM_BOOL;
          break;
        case is_null($value):
          $type = PDO::PARAM_NULL;
          break;
        default:
          $type = PDO::PARAM_STR;
      }
    }

    $this->stmt->bindValue($param, $value, $type);

    return $this;
  }

  public function bindAll($array) {
    foreach ($array as $value) {
      $this->bind($value[0], $value[1], $value[2]); // param, value, type
    }

    return $this;
  }

  public function execute() {
    return $this->stmt->execute();
  }

  public function fetchAll($fetch_type = PDO::FETCH_ASSOC) {
    $this->execute();
    return $this->stmt->fetchAll($fetch_type);
  }

  public function fetch($fetch_type = PDO::FETCH_ASSOC) {
    $this->execute();
    return $this->stmt->fetch($fetch_type);
  }

  public function rowCount() {
    return $this->stmt->rowCount();
  }

  public function lastInsertId() {
    return $this->dbh->lastInsertId();
  }

  public function beginTransaction() {
    return $this->dbh->beginTransaction();
  }

  public function endTransaction() {
    return $this->dbh->commit();
  }

  public function cancelTransaction() {
    return $this->dbh->rollBack();
  }

  public function debugDumpParams() {
    return $this->stmt->debugDumpParams();
  }

  public function getErrors() {
    return $this->error;
  }
}
