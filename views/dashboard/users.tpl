<header class="ui-primary-header">
  <h1>Users</h1>
  <a href="/dashboard/user/new" class="ui-btn-primary ui-iconed ui-icon-add">Add New</a>
</header>
<div class="content">
  <table class="ui-table">
    <tr class="ui-table-header">
      <th width="4%">#</th>
      <th width="14%">Username</th>
      <th width="19%">Name</th>
      <th width="24%">E-mail</th>
      <th width="15%">Role</th>
      <th width="15%">Actions</th>
    </tr>
    <?php foreach($users as $user): ?>
    <tr data-user-id="<?=$user["id"]?>" data-role="<?=$user["role"]?>">
      <td><?=$user["id"]?></td>
      <td><?=$user["username"]?></td>
      <td><?=$user["name"]?></td>
      <td><?=$user["email"]?></td>
      <td><?=ucfirst($user["role"])?></td>
      <td>
        <ul>
          <li><a href="/dashboard/user/<?=$user["id"]?>" class="ui-btn-secondary ui-iconed edit">Edit</a></li>
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
<script src="/assets/js/users.js"></script>
