<?php

error_reporting(E_ALL ^ E_NOTICE);

header("Content-Type: text/html; charset=utf-8");
date_default_timezone_set("Europe/Belgrade");

define("BASE_URL", "/");
define("ROOT_DIR", $_SERVER['DOCUMENT_ROOT'] . BASE_URL);

session_start();

$request = "/" . $_GET["route"];
require_once "app/app.php";
