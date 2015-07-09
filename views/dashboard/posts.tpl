<header class="ui-primary-header">
  <h1>Posts</h1>
  <a href="/dashboard/post/new" class="ui-btn-primary ui-iconed ui-icon-add">Add New</a>
  <span class="ui-counter">Total Posts: <?= count($posts) ?></span>
</header>
<div class="content">

  <table class="ui-table">
    <tr class="ui-table-header">
      <th width="33%">Title</th>
      <th width="16%">Author</th>
      <th width="14%">Posted</th>
      <th width="10%">Likes</th>
      <th width="23%">Actions</th>
    </tr>

    <?php foreach ($posts as $post): ?>
      <tr data-post-id="<?=$post["id"]?>">
        <td><a href="/dashboard/post/<?=$post["id"]?>" title="View Post" target="_blank"><?=$post["title"]?></a></td>
        <td><?=$post["author_name"]?></td>
        <td><?=formatDate($post["created_at"])?></td>
        <td><?=$post["likes"]?></td>
        <td>
          <ul>
            <li><a href="/post/<?=$post["id"]?>" title="View Post" target="_blank" class="ui-btn-secondary ui-iconed view">View</a></li>
            <li><a href="/dashboard/post/<?=$post["id"]?>" class="ui-btn-secondary ui-iconed edit">Edit</a></li>
            <li class="ui-btn-secondary ui-iconed delete">Delete</li>
          </ul>
        </td>
      </tr>
    <?php endforeach ?>
  </table>
  <div class="load-more">
    <!-- <span class="loaded">No more posts to show.</span> -->
    <span class="ui-btn-primary ui-iconed ui-big" id="load-more">Load More</span>
  </div>
</div>
<script src="/assets/js/posts.js"></script>
