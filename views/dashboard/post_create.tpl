<header class="ui-primary-header">
    <h1>New Post</h1>
    <ul class="actions">
      <li><span class="ui-btn-secondary" data-action="cancel">Cancel</span></li>
      <li><span class="ui-btn-primary" data-action="publish">Publish</span></li>
    </ul>

  </header>
  <div class="content stretched">
    <input type="text" name="title" class="ui-input-title" placeholder="Title" autofocus value="<?=$post["title"]?>">
    <div class="post-content clearfix">
      <div class="post-markdown post-window">
        <span class="post-window-title">Markdown <a href="http://daringfireball.net/projects/markdown/syntax" title="Markdown Reference" target="_blank" class="md-reference"></a></span>
        <textarea name="content_md" class="post-markdown-field" placeholder="Post Content..."><?=$post["content_md"]?></textarea>
        <input type="hidden" id="post-id" value="<?=$post["id"]?>">
      </div>
      <div class="post-preview post-window">
        <span class="post-window-title">Preview <span class="counter">0 Words</span></span>
        <div class="post-preview-html"><?=$post["content_html"]?></div>
      </div>
    </div>
  </div>
<script src="/assets/js/markdown.min.js"></script>
<script src="/assets/js/post_new.js"></script>
