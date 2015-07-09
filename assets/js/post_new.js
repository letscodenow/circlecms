(function() {

  var Post = {
    _id:       $.ge("#post-id"),
    _title:    $.ge(".ui-input-title"),
    _markdown: $.ge(".post-markdown-field"),
    _html:     $.ge(".post-preview-html"),
    _words_counter: $.ge(".post-window-title .counter"),

    get id(){
      return parseInt(this.id.value) || 0;
    },

    get title() {
      return this._title.value.trim();
    },

    get md() {
      return this._markdown.value.trim();
    },

    get html() {
      return this._html.value.trim();
    },

    get validate() {
      return !(this._title.value === "" || this._markdown.value === "");
    },

    get isEmpty(){
      return (this._title.value === "" && this._markdown.value === "");
    },

    getText: function(el){
      ret = "";
      var length = el.childNodes.length;
      for(var i = 0; i < length; i++) {
        var node = el.childNodes[i];
          if(node.nodeType != 8) {
            ret += node.nodeType != 1 ? node.nodeValue : this.getText(node);
          }
      }
      return ret;
    },

    get countWords(){
      var words = this.getText(this._html);
      var count = words.match(/[^\s]+/g) ? words.match(/[^\s]+/g).length : 0;

      return count;
    },

    updateCounter: function(){
      this._words_counter.innerHTML = (this.countWords === 1) ? this.countWords + " word" : this.countWords + " words";
    },

    init: function(preview) {
      var _this = this;

      // if($.storage.get("draft")){
      //   var _post = JSON.parse($.storage.get("draft"));
      //   _this._title.value = _post.title;
      //   _this._markdown.value = _post.markdown;
      //   preview.innerHTML = markdown.toHTML(_post.markdown);
      //
      //   this.updateCounter();
      // }

      this._markdown.onkeyup = function() {
        preview.innerHTML = markdown.toHTML(_this.md);
        _this.updateCounter();
      };
    }

  };

  var Actions = {

    buttons: {
      cancel:  $.ge(".ui-btn-secondary[data-action='cancel']"),
      publish: $.ge(".ui-btn-primary[data-action='publish']")
    },

    cancel: function(){
      if(!Post.isEmpty){
        if(!confirm(lang.post_new_cancel)){
          return;
        }
      }
      window.location = "/dashboard/posts";
    },

    publish: function(){
      if(Post.validate){
        $.post("/api/post/save", {
          data: {
            id: Post._id.value,
            title: Post._title.value,
            content_md: Post._markdown.value
          },
          success: function(response){
            response = JSON.parse(response);
            if(!response.error){

              if(Post._id !== 0){
                alert(lang.post_updated);
              } else {
                alert(lang.post_published);
              }

              window.location = "/dashboard/posts";
            } else {
              alert(response.error.msg);
            }
          },
          error: XHRError
        });
      } else {
        alert(lang.post_publish_error);
      }
    },

    init: function(){
      Actions.buttons.cancel.onclick  = this.cancel;
      Actions.buttons.publish.onclick = this.publish;
    }

  }

  Post.init(Post._html);
  Actions.init();

  })();
