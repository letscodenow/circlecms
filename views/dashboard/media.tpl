<?php if($add_error): ?>
  <script>
    alert(<?=$add_error?>);
  </script>
<?php endif ?>

<?php
  $protocol = strtolower(substr($_SERVER["SERVER_PROTOCOL"],0,strpos( $_SERVER["SERVER_PROTOCOL"],'/'))).'://';
  $hostname = $_SERVER['SERVER_NAME'];
  $port = $_SERVER['SERVER_PORT'] == 80 ? "" : $_SERVER['SERVER_PORT'];
?>

<header class="ui-primary-header">
    <h1>Media</h1>
    <form action="#" method="POST" enctype="multipart/form-data" class="media-add-form">
      <span class="ui-btn-primary ui-iconed ui-icon-add">Add New</span>
      <input type="file" name="media-file" class="media-add-btn">
    </form>
  </header>
  <div class="content">
    <table class="ui-table">
      <tr class="ui-table-header">
        <th width="26%">Image</th>
        <th width="33%">URL</th>
        <th width="16%">Added by</th>
        <th width="15%">Date</th>
        <th width="10%">Actions</th>
      </tr>

      <?php foreach($media as $one): ?>

      <tr data-media-id="<?=$one["id"]?>">
        <td>
          <a href="<?=$protocol.$hostname.$port?><?=$one["media_file"]?>" title="View <?=$one["media_name"]?>" target="_blank" class="img-link">
            <span style="background-image: url(<?=$protocol.$hostname.$port?><?=$one["media_file"]?>)" class="image"></span>
            <span class="image-name"><?=$one["media_name"]?></span>
          </a>
        </td>
        <td><input type="text" class="ui-input small" value="<?=$protocol.$hostname.$port?><?=$one["media_file"]?>"></td>
        <td><?=$one["author_name"]?></td>
        <td><?=formatDate($one["created_at"])?></td>
        <td>
          <ul>
            <li class="ui-btn-secondary ui-iconed delete">Delete</li>
          </ul>
        </td>
      </tr>
      <?php endforeach ?>

    </table>
    <div class="load-more">
      <span class="ui-btn-primary ui-iconed ui-big" id="load-more">Load More</span>
    </div>
  </div>
<script src="/assets/js/media.js"></script>
