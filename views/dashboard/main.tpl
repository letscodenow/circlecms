<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta charset="UTF-8">
  <meta name="description" content="CircleCMS - <?=$title?>">
  <noscript><meta http-equiv="refresh" content="0; URL=http://browsehappy.com/"></noscript>
  <link rel="shortcut icon" href="/assets/img/favicon.ico">

  <title><?=$title?></title>

  <!--[if lt IE 8]><script type="text/javascript">window.location.href = 'http://browsehappy.com/'</script><![endif]-->
  <link rel="stylesheet" href="/assets/css/db_index.css">
  <script src="/assets/js/core.js"></script>
  <script src="/assets/js/ui.js"></script>
</head>
<body>
  <aside class="ui-sidebar">
    <nav>
      <ul>
        <li class="circlecms-logo"></li>
        <li class="ui-nav posts"><a href="/dashboard/posts" data-tooltip="Posts"></a></li>
        <?php if ($_SESSION["user"]["user_role"] === "administrator"): ?>
        <li class="ui-nav users"><a href="/dashboard/users" data-tooltip="Users"></a></li>
        <?php endif ?>
        <li class="ui-nav media"><a href="/dashboard/media" data-tooltip="Media"></a></li>
        <li class="ui-nav signout"><a href="/dashboard/signout" data-tooltip="Signout"></a></li>
      </ul>
    </nav>
  </aside>
  <?=$content?>
</body>
</html>
