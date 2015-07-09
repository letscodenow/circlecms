<?php

function setResponseCode($code) {
  //http_response_code($code);
}

function error($code, $ext = "html") {
  // setResponseCode($code);
  echo file_get_contents(ROOT_DIR . "views/errors/{$code}.{$ext}");
}

function json($data, $code = 0) {
  if ($code != 0) {
    setResponseCode($code);
  }

  echo json_encode($data);
}

function formatDate($date) {
  $time = strtotime($date);

  $date_year = date("Y", $time);
  $current_year = date("Y", time());

  if ($current_year == $date_year) {
    $pattern = "d M, H:i";
  } else {
    $pattern = "d M 'y, H:i";
  }

  unset($date_year, $current_year, $date);
  return date($pattern, $time);
}

function template($file_path = null, $params = array()) {
  if (empty($file_path)) {
    return;
  };

  $file_path = ROOT_DIR . "views/$file_path.tpl";

  ob_start();

  foreach ($params as $key => $value) {
      $$key = $value;
  };

  include $file_path;

  return ob_get_clean();
}
