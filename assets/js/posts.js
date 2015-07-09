(function(o){

  var _i = 0,
      offset = o,
      step   = 10,
      limit  = 10;

  var table = $.ge(".ui-table");
  var loadMore = $.ge("#load-more");

  function setDeleteListeners(){
    var deleteButtons = $.geAll("li.delete");

    for(_i, l = deleteButtons.length; _i < l; _i++){
      $.bindEvent(deleteButtons[_i], "click", function(){
        var row = this.parentNode.parentNode.parentNode,
            id  = row.getAttribute("data-post-id");
        if(confirm(lang.delete_confirmation)){
          deleteRow(row, id);
        }
      });
    }
  }

  function deleteRow(row, id){
    $.post("/api/post/delete", {
      data: {
        id: id
      },
      success: function(data){
        var response = JSON.parse(data);

        if(response.error){
          alert(lang.error_code + ": " + response.error.code + "\n" + lang.error_description + ": " + response.error.msg);
          return;
        }

        deleteFromDOM(row, id);
      },
      error: XHRError
    });
  }

  function deleteFromDOM(row, id){
    var tr = document.createElement("tr");
    tr.innerHTML = "<td colspan=\"5\" class=\"deleted\">" + lang.post_deleted + "</td>";
    $.replaceChild(row, tr);
  }

  function XHRError(error_code){
    var message = "";
    if(error_code == 0){
      message = lang.error_protocol_description + " \"" + (location.protocol).slice(0, -1) + "\" " + lang.error_protocol + ".";
    } else {
      message = lang.error_server + "\n\n" + lang.error_code + ": " + error_code;
    }
    alert(message);
  }

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

  function getPosts(){
    $.get("/api/posts?offset=" + offset + "&limit=" + limit + "&explicit=false", {
      success: function(data){
        var response = JSON.parse(data);

        if(response.error){
          $.ge(".load-more").innerHTML = "<span class=\"loaded\">" + lang.posts_loaded + "</span>";
          return;
        }

        var insert = '';

        for(var _j = 0, l = response.posts.length; _j < l; _j++){
          insert += '\
          <tr data-post-id="'+ response.posts[_j].id +'">\
            <td><a href="/post/'+ response.posts[_j].id +'" title="'+ lang.post_view +'" target="_blank">'+ response.posts[_j].title +'</a></td>\
            <td>'+ response.posts[_j].author_name +'</td>\
            <td>'+ humanTime(response.posts[_j].created_at) +'</td>\
            <td>'+ response.posts[_j].likes +'</td>\
            <td>\
              <ul>\
                <li><a href="/post/'+ response.posts[_j].id +'" title="' + lang.post_view + '" target="_blank" class="ui-btn-secondary ui-iconed view">' + lang.view + '</a></li>\
                <li><a href="/dashboard/post/'+ response.posts[_j].id +'" class="ui-btn-secondary ui-iconed edit">' + lang.edit + '</a></li>\
                <li class="ui-btn-secondary ui-iconed delete">' + lang.delete + '</li>\
              </ul>\
            </td>\
          </tr>';
        }

        table.innerHTML += insert;
        offset += step;
        setDeleteListeners();

      },
      error: XHRError
    });
  }

  $.bindEvent(loadMore, "click", getPosts);

  setDeleteListeners();
})($.geAll('tr').length - 1);
