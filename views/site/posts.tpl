<div class="content">
  <?php foreach($posts as $post): ?>
  <article>
    <span class="date"><?=formatDate($post["created_at"])?></span>
    <h2 class="title"><a href="/post/<?=$post["id"]?>"><?=$post["title"]?></a></h2>
    <span class="author">by <?=$post["author_name"]?></span>
    <div class="content">
      <?=$post["preview_html"]?>
      <a href="/post/<?=$post["id"]?>" class="continue-reading">Continue Reading</a>
    </div>
  </article>
  <?php endforeach ?>
</div>
<div class="load-more-container">
  <span class="load-more">Load More</span>
</div>
<script src="/assets/js/core.js"></script>
<script>

(function(o){
var loadMore = $.ge(".load-more");

var content = $.ge(".content");

var offset = o,
    step   = 10,
    limit  = 10;

function humanTime(time){
  var month = time.slice(5,7);
  var date = time.slice(8,10);
  var time = time.slice(11,16);
  var result = "";

  var months = {
    "01": "Januar",
    "02": "Februar",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December"
  };

  result = date + " " + months[month] + ", " + time;

  return result;
}

$.bindEvent(loadMore, "click", function(){
  $.get('/api/posts?offset='+offset+'&limit='+limit+'&explicit=true', {
    success: function(response){
      response = JSON.parse(response);

      if(response.error){
        $.ge(".load-more-container").innerHTML = "All Posts Loaded";
        return;
      }

      var insert = '';

      for(var _j = 0, l = response.posts.length; _j < l; _j++){
        insert += '\
        <article>\
          <span class="date">'+ humanTime(response.posts[_j].created_at) +'</span>\
          <h2 class="title"><a href="/post/'+ response.posts[_j].id +'">'+ response.posts[_j].title +'</a></h2>\
          <span class="author">by '+ response.posts[_j].author_name +'</span>\
          <div class="content">\
            '+ response.posts[_j].content_html +'\
            <a href="/post/'+ response.posts[_j].id +'" class="continue-reading">Continue Reading</a>\
          </div>\
        </article>';
      }

      content.innerHTML += insert;
      offset += step;
    },
    error: function(){
      alert("Oops, server error.");
    }
  });
});
})($.geAll("article").length)
</script>
