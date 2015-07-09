$.DOMReady(function(){
  var inputs = $.geAll("input"),
      submit = $.ge(".submit"),
      error  = $.ge(".error"),
      validatedInputs = [];

  for(var i = 0, l = inputs.length; i < l; i++){
    $.bindEvent(inputs[i], "keyup", function(){

      if((this.value).trim() !== ""){
        if(validatedInputs.indexOf(this.name) == -1){
          validatedInputs.push(this.name);
        }
      } else if((this.value).trim() == "" && validatedInputs.indexOf(this.name) > -1){
        validatedInputs.splice(validatedInputs.indexOf(this.name), 1);
      }

      preValidateForm();

    });
  }

  // just checks for matching

  function preValidateForm(){
    if(validatedInputs.length == inputs.length){
      submit.setAttribute("data-state", "enabled");
      $.bindEvent(submit, "click", submitForm);
      $.bindEvent(window, "keypress", submitForm);
    } else {
      submit.setAttribute("data-state", "disabled");
      $.removeEvent(submit, "click", submitForm);
      $.removeEvent(window, "keypress", submitForm);
    }
  }

  function valid(){
    if((inputs[0].value).trim() !== "" && (inputs[1].value).trim() !== ""){
      return true;
    }
  }

  function submitForm(e){
    if(e.type == "keypress" && e.keyCode !== 13)
      return;

    if(valid()){
      $.post("/api/auth", {
        data: {
          "username": inputs[0].value,
          "password": inputs[1].value
        },
        "success": function(data){
          var response = JSON.parse(data);
          if(!response.error){
            window.location.reload(); // just update the page
          } else {

            // "User not found" or "The user password doesn't match"
            if(response.error.code == 1 || response.error.code == 2){
              enableError();
            } else {
              alert(lang.error_code + ": " + response.error.code + "\n" + lang.error_description + ": " + response.error.msg);
            }
          }
        },
        "error": function(status){
          var message = "";
          if(status == 0){
            message = lang.error_protocol_description + " \"" + (location.protocol).slice(0, -1) + "\" " + lang.error_protocol + ".";
          } else {
            message = lang.error_server + "\n\n" + lang.error_code + ": " + status;
          }
          alert(message);
        }
      });
    }
  }

  function enableError(){
    error.setAttribute("data-active", "true");
  }
});
