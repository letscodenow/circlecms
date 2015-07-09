<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta charset="UTF-8">
  <meta name="description" content="CircleCMS - Sign In">
  <noscript><meta http-equiv="refresh" content="0; URL=http://browsehappy.com/"></noscript>
  <link rel="shortcut icon" href="assets/img/favicon.ico">

  <title>Sign In to continue | CircleCMS</title>

  <!--[if lt IE 8]><script type="text/javascript">window.location.href = 'http://browsehappy.com/'</script><![endif]-->
  <link rel="stylesheet" href="assets/css/db_index.css">
  <script src="assets/js/core.js"></script>
  <script src="assets/js/ui.js"></script>
  <script src="assets/js/auth.js"></script>
</head>
<body class="signin">
  <div class="container">
    <a href="/dashboard" title="CircleCMS Dashboard" class="logo-big"></a>
    <h1>Sign In to continue</h1>
    <input type="text" name="username" placeholder="Username" autofocus>
    <input type="password" name="password" placeholder="•••••••••">
    <span class="submit" data-state="disabled"></span>
    <span class="error" data-active="false">Username or password is invalid</span>
  </div>
</body>
</html>
