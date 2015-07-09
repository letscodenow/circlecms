(function(){

  var fields = $.geAll("input");
  var combobox = $.ge(".ui-radio-combobox");
  var comboboxOptions = combobox.getElementsByTagName("li");

  for(var _i = 0, _l = fields.length - 1; _i < _l; _i++){
    $.bindEvent(fields[_i], "keyup", function(e){
      validateInput(e, this.value);
    });
  }

  function validateInput(e, value){
    if(e.target.name === "username" && value.length > 2){
      $.post("/api/user/check", {
        data: {
          username: value
        },
        success: function(response){
          response = JSON.parse(response);
          if(response.status) {
            alert(lang.name_is_taken);
          }
        },
        error: XHRError
      });
    }
  }


  for(var _i = 0, _l = comboboxOptions.length; _i < _l; _i++){
    $.bindEvent(comboboxOptions[_i], "click", function(){
      if(this.getAttribute("data-state") !== "active"){
        $.ge('[data-state="active"]', combobox).removeAttribute("data-state");
        this.setAttribute('data-state', 'active');
        $.ge('input[name="role"]').setAttribute('value', this.getAttribute('data-role'));
      }
    });
  }

  $.bindEvent($.ge('.ui-btn-secondary[data-action="cancel"]'), "click", function(){
    if(confirm(lang.post_new_cancel)){
      window.location = "/dashboard/users";
    }
  });

  $.bindEvent($.ge('.ui-btn-primary[data-action="publish"]'), "click", function(){

    var data = {
      username  : $.ge('input[name="username"]').value,
      name      : $.ge('input[name="name"]').value,
      email     : $.ge('input[name="email"]').value,
      password  : $.ge('input[name="password"]').value,
      role      : $.ge('input[name="role"]').value,
    };

    var is_update = false;

    if($.ge('input[name="id"]')){
      data.id = $.ge('input[name="id"]').value;
      is_update = true;
    }

    $.post("/api/user/save", {
      data: data,
      success: function(res){
        res = JSON.parse(res);
        var msg = '';

        if(!res.error){
          msg = (!is_update) ? lang.user_added : lang.user_updated;

          alert(msg);
          window.location = "/dashboard/users";
        } else {
          alert(res.error.msg);
        }
      },
      error: XHRError
    });

  });

})();
