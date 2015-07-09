(function(o){

  var _i = 0,
      offset = o,
      step   = 10,
      limit  = 10;

  var table = $.ge(".ui-table");
  var loadMore = $.ge("#load-more");

  var addMedia = $.ge('.media-add-btn');
  var addForm = $.ge('.media-add-form');
  var addButtonUI = $.ge('.ui-btn-primary', addForm);

  function setDeleteListeners(){
    var deleteButtons = $.geAll("li.delete");

    for(_i, l = deleteButtons.length; _i < l; _i++){
      $.bindEvent(deleteButtons[_i], "click", function(){
        var row = this.parentNode.parentNode.parentNode,
            id  = row.getAttribute("data-media-id");
        if(confirm(lang.delete_confirmation)){
          deleteRow(row, id);
        }
      });
    }
  }

  function setSelectListeners(){
    var inputs = $.geAll(".ui-input");

    for(_n = 0, l = inputs.length; _n < l; _n++){
      $.bindEvent(inputs[_n], "click", function(){
        this.select();
      });
    }
  }

  function deleteRow(row, id){
    $.post("/api/media/delete", {
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
    tr.innerHTML = "<td colspan=\"5\" class=\"deleted\">" + lang.media_deleted + "</td>";
    $.replaceChild(row, tr);
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

  function getMedia(){
    $.get("/api/media?offset=" + offset + "&limit=" + limit, {
      success: function(data){
        var response = JSON.parse(data);

        if(response.error){
          $.ge(".load-more").innerHTML = "<span class=\"loaded\">" + lang.media_loaded + "</span>";
          return;
        }

        var insert = '';

        for(var _j = 0, l = response.media.length; _j < l; _j++){
          insert += '\
          <tr data-media-id="1">\
            <td>\
              <a href="'+ window.location.protocol + "//" + window.location.hostname + response.media[_j].media_file + '" title="View '+ response.media[_j].media_name +'" target="_blank" class="img-link">\
                <span style="background-image: url('+ window.location.protocol + "//" + window.location.hostname + response.media[_j].media_file + ')" class="image"></span>\
                <span class="image-name">'+ response.media[_j].media_name +'</span>\
              </a>\
            </td>\
            <td><input type="text" class="ui-input small" value="'+ window.location.protocol + "//" + window.location.hostname + response.media[_j].media_file + '"></td>\
            <td>'+ response.media[_j].author_name +'</td>\
            <td>'+ humanTime(response.media[_j].created_at) +'</td>\
            <td>\
              <ul>\
                <li class="ui-btn-secondary ui-iconed delete">Delete</li>\
              </ul>\
            </td>\
          </tr>';
        }

        table.innerHTML += insert;
        offset += step;
        setDeleteListeners();
        setSelectListeners();

      },
      error: XHRError
    });
  }

  $.bindEvent(loadMore, "click", getMedia);

  $.bindEvent(addButtonUI, "click", function(){
    addMedia.click();
  });

  $.bindEvent(addMedia, "change", function(){
    if(this.files.length > 0){
      addForm.submit();
    }
  });

  setDeleteListeners();
  setSelectListeners();
})($.geAll('tr').length - 1);
