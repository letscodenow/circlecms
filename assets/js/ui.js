var lang = {
  delete_confirmation: "Are you sure you want to delete this?",
  error_code: "Error Code",
  error_description: "Error Description",
  error_protocol_description: "You can't perform requests using",
  error_protocol: "protocol",
  error_server: "Argh, something went wrong with the server.\nTry again.",
  post_deleted: "Post Deleted.",
  posts_loaded: "No more posts to show.",
  post_view: "View Post",
  post_new_cancel: "Are you sure you want to cancel?\nChanges won't be saved.",
  post_published: "Post has been successfully published!",
  post_updated: "Post has been successfully updated!",
  post_not_exists: "The post doesn't exist",
  post_not_changed: "The post hasn't been added",
  user_deleted: "User Deleted.",
  user_lastadmin: "You cannot delete the last administrator.",
  users_loaded: "No more users to show.",
  name_is_taken: "Username is taken, try something else",
  email_is_taken: "This e-mail is already in use.",
  user_added: "User has been successfully added.",
  user_updated: "User has been successfully updated",
  media_deleted: "File Deleted.",
  media_loaded: "No more media to show.",
  view: "View",
  edit: "Edit",
  delete: "Delete",
  system: {
    unauthorized: "Unauthorized",
    bad_request: "Bad Request"
  }
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

$.DOMReady(function(){
  $.ge("body").classList.add($.getBrowser().name);

  var header = $.ge('.ui-primary-header'),
      title  = $.ge("h1", header),
      actions = $.geAll("span", header);

  // URL Mathcer

  if((window.location.href).match(/(?:post)\/(\d{1,})/)){
    title.innerHTML = "Editing Post";
    actions[1].innerHTML = "Update";
  }

  if((window.location.href).match(/(?:user)\/(\d{1,})/)){
    actions[1].innerHTML = "Update";
  }


  var navigation = $.ge(".ui-sidebar ul");

  if((window.location.href).match(/(?:user)/)){
    $.ge(".users", navigation).classList.add('active');
  }

  if((window.location.href).match(/(?:post)/)){
    $.ge(".posts", navigation).classList.add('active');
  }

  if((window.location.href).match(/(?:media)/)){
    $.ge(".media", navigation).classList.add('active');
  }

});
