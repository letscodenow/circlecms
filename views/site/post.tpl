<article>
      <span class="date"><?=formatDate($post["created_at"])?></span>
      <h2 class="title"><?=$post["title"]?></h2>
      <span class="author">by <?=$post["author_name"]?></span>
      <div class="content">
        <?=$post["content_html"]?>
      </div>
    </article>
    <a href="/" title="Back Home" class="back-home">Back Home</a>
    <span class="like"><?=$post["likes"]?></span>
  </div>
<script src="/assets/js/core.js"></script>
<script>
  (function(){

    var like = $.ge(".like");
    var post_id = <?=$post["id"]?>;

    var l = JSON.parse($.storage.get("postLikes")) || {};
    var i = l[post_id] ? 1 : 0;

    if(i){
      like.setAttribute('data-liked', 'true');
    }

    $.bindEvent(like, "click", function(){

      var likes = JSON.parse($.storage.get("postLikes")) || {};
      var is_liked = likes[post_id] ? 1 : 0;

      var mode = '';

      if(!is_liked){
        mode = 'add';
      } else {
        mode = 'delete'
      }

      function handleLikes(mode){
        if(mode === 'add'){
          likes[post_id] = 1;
          like.setAttribute('data-liked', 'true');

          like.textContent = parseInt(like.textContent) + 1;
        } else {
          likes[post_id] = 0;
          like.removeAttribute('data-liked');

          like.textContent = parseInt(like.textContent) - 1;
        }

        $.storage.set("postLikes", JSON.stringify(likes));

      }

      $.get("/api/post/likes/" + mode + "?id=" + post_id, {
        success: function(res){
          res = JSON.parse(res);
          if(!res.error){
            handleLikes(mode);
          } else {
            alert(res.error.msg);
          }
        },
        error: function(){
          alert("Server error :(\nTry again");
        }
      })

    });

  })();
</script>
<!--
<style>
  #likes {
    display: inline-block;
    padding: 3px 10px;
    background: #3B629C;
    cursor: pointer;
    color: #fff;
    font-family: Arial, sans-serif;
  }
</style>

<h1><?=$post["title"]?></h1>

<?=$post["content_html"]?>

<small>
  Author: <a href="/user/<?=$post["author_id"]?>"><?=$post["author_name"]?></a> |
  Posted: <?=formatDate($post["created_at"])?> |

  <span id="likes">
    <span id="likes-action">Like</span>
    <span id="likes-count"><?=$post["likes"]?></span>
  </span>
</small>

<script>
  (function() {
    var likesBtn = document.getElementById("likes"),
        likesAction = document.getElementById("likes-action"),
        likesCount = document.getElementById("likes-count");

    var ls = JSON.parse(localStorage.getItem("postsLikes")) || {};
    var postId = parseInt(location.pathname.replace("/post/", ""));

    if (parseInt(likesCount.innerHTML) === 0) {
      ls[postId] = false;
    }

    if (ls[postId]) {
      likesAction.innerHTML = "Dislike"
    }

    likesBtn.onclick = function() {
      var mode;

      if (ls[postId]) {
        ls[postId] = false;
        mode = "delete";
      } else {
        ls[postId] = true;
        mode = "add";
      }

      var xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
        if (xhr.readyState != 4) {
          return;
        }

        if (xhr.status !== 200) {
          return alert("Cannot like this blog post. Please, try later.");
        }

        if (mode === "add") {
          likesAction.innerHTML = "Dislike";
          likesCount.innerHTML = parseInt(likesCount.innerHTML) + 1;
        } else {
          likesAction.innerHTML = "Like";
          likesCount.innerHTML = parseInt(likesCount.innerHTML) - 1;
        }

        localStorage.setItem("postsLikes", JSON.stringify(ls));
      };

      xhr.open("GET", "/api/post/likes/" + mode + "?id=" + postId, true);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xhr.send();
    };
  })();
</script> -->
