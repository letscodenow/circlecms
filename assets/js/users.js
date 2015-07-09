(function(o){

  var _i = 0,
      offset = o,
      step   = 10,
      limit  = 10;

  var table = $.ge(".ui-table");
  var loadMore = $.ge("#load-more");

  var admins = $.geAll('[data-role="administrator"]');

  function setDeleteListeners(){
    var deleteButtons = $.geAll("li.delete");

    for(_i, l = deleteButtons.length; _i < l; _i++){
      $.bindEvent(deleteButtons[_i], "click", function(){
        var row = this.parentNode.parentNode.parentNode,
            id  = row.getAttribute("data-user-id");
        if(confirm(lang.delete_confirmation)){
          deleteRow(row, id);
        }
      });
    }

    updateAdmins();
  }

  function deleteRow(row, id){

    if(admins.length === 1 && row.getAttribute("data-role") === "administrator"){
      return alert(lang.user_lastadmin);
    }

    $.post("/api/user/delete", {
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
    tr.innerHTML = "<td colspan=\"6\" class=\"deleted\">" + lang.user_deleted + "</td>";
    $.replaceChild(row, tr);

    updateAdmins();
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

  function getUsers(){
    $.get("/api/users?offset=" + offset + "&limit=" + limit, {
      success: function(data){
        var response = JSON.parse(data);

        if(response.error){
          $.ge(".load-more").innerHTML = "<span class=\"loaded\">" + lang.users_loaded + "</span>";
          return;
        }

        var insert = '';

        for(var _j = 0, l = response.users.length; _j < l; _j++){
          insert += '\
          <tr data-user-id="'+ response.users[_j].id +'">\
            <td>'+ response.users[_j].id +'</td>\
            <td>'+ response.users[_j].username +'</td>\
            <td>'+ response.users[_j].name +'</td>\
            <td>'+ response.users[_j].email +'</td>\
            <td>'+ response.users[_j].role +'</td>\
            <td>\
              <ul>\
                <li><a href="/dashboard/user/'+ response.users[_j].id +'" class="ui-btn-secondary ui-iconed edit">Edit</a></li>\
                <li class="ui-btn-secondary ui-iconed delete">Delete</li>\
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

  function updateAdmins(){
    admins = $.geAll('[data-role="administrator"]');
  }

  $.bindEvent(loadMore, "click", getUsers);

  setDeleteListeners();
})($.geAll('tr').length - 1);
