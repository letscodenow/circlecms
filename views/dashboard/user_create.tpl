<header class="ui-primary-header">
    <h1>
      <?php if ($user["id"]): ?>
        Editing User
      <?php else: ?>
        New User
      <?php endif ?>
    </h1>
    <ul class="actions">
      <li><span class="ui-btn-secondary" data-action="cancel">Cancel</span></li>
      <li><span class="ui-btn-primary" data-action="publish">Add User</span></li>
    </ul>
  </header>
  <div class="content stretched">
    <dl class="new-user-form">
      <dt>Username</dt>
      <dd><input type="text" name="username" class="ui-input" placeholder="jedmery_87" autofocus value="<?=$user["username"]?>"></dd>
      <dt>Name</dt>
      <dd><input type="text" name="name" class="ui-input" placeholder="Dmitry Fomin" value="<?=$user["name"]?>"></dd>
      <dt>E-mail</dt>
      <dd><input type="text" name="email" class="ui-input" placeholder="example@domain.com" value="<?=$user["email"]?>"></dd>
      <dt>Password</dt>
      <dd><input type="password" name="password" class="ui-input" placeholder="••••••••••"></dd>
      <dt>Role</dt>
      <dd>
        <ul class="ui-radio-combobox">
          <?php if(!$user["role"]): ?>
            <li data-role="editor" data-state="active">Editor</li>
            <li data-role="administrator">Administrator</li>
          <?php else: ?>
            <li data-role="editor" data-state="<?= $user["role"] === "editor" ? "active" : "" ?>">Editor</li>
            <li data-role="administrator" data-state="<?= $user["role"] === "administrator" ? "active" : "" ?>">Administrator</li>
          <?php endif ?>
        </ul>
        <input type="hidden" name="role" value="<?=$user["role"]?>">
      </dd>
    </dl>
    <input type="hidden" name="id" value="<?=$user["id"]?>">
  </div>
<script src="/assets/js/user_new.js"></script>
