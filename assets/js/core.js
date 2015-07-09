(function(exports){

    /*==========================================*/
    /* Polyfills */
    /*==========================================*/

    // Document.querySelectorAll method
    // http://ajaxian.com/archives/creating-a-queryselector-for-ie-that-runs-at-native-speed
    // Needed for: IE7-
    if (!document.querySelectorAll) {
        document.querySelectorAll = function(selectors) {
            var style = document.createElement('style'), elements = [], element;
            document.documentElement.firstChild.appendChild(style);
            document._qsa = [];

            style.styleSheet.cssText = selectors + '{x-qsa:expression(document._qsa && document._qsa.push(this))}';
            window.scrollBy(0, 0);
            style.parentNode.removeChild(style);

            while (document._qsa.length) {
                element = document._qsa.shift();
                element.style.removeAttribute('x-qsa');
                elements.push(element);
            }
            document._qsa = null;
            return elements;
        };
    }

    // Document.querySelector method
    // Needed for: IE7-
    if (!document.querySelector) {
        document.querySelector = function(selectors) {
            var elements = document.querySelectorAll(selectors);
            return (elements.length) ? elements[0] : null;
        };
    }

    // ES5 15.2.3.14 Object.keys ( O )
    // https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Object/keys
    if (!Object.keys) {
        Object.keys = function (o) {
            if (o !== Object(o)) { throw TypeError('Object.keys called on non-object'); }
                var ret = [], p;
                for (p in o) {
                    if (Object.prototype.hasOwnProperty.call(o, p)) {
                        ret.push(p);
                    }
                }
            return ret;
        };
    }

    if (!Date.now) {
        Date.now = function() { return new Date().getTime(); };
    }

    /*==========================================*/
    /* Selectors */
    /*==========================================*/

    exports.ge = function(element, parent){
        var parent = (typeof parent !== "undefined") ? parent : document;

        if(parent.querySelector){
            return parent.querySelector(element);
        }
    }

    exports.geAll = function(element, parent){
        var parent = (typeof parent !== "undefined") ? parent : document;

        if(parent.querySelectorAll){
            return parent.querySelectorAll(element);
        }
    }

    /*==========================================*/
    /* Events */
    /*==========================================*/

    exports.bindEvent = function(element, event, handler){
        if(document.addEventListener){
            return element.addEventListener(event, handler, false);
        } else if(document.attachEvent){
            return element.attachEvent("on"+event, handler);
        }
    }

    exports.removeEvent = function(element, event, handler){
        if(document.removeEventListener){
            return element.removeEventListener(event, handler, false);
        } else if(document.detachEvent){
            return element.detachEvent("on"+event, handler);
        }
    }

    exports.DOMReady = function (callback) {

        /*@cc_on
            @if (@_win32 || @_win64)
            document.write('<script id="ieScriptLoad" defer src="//:"><\/script>');
            document.getElementById('ieScriptLoad').onreadystatechange = function() {
                if (this.readyState == 'complete') {
                    callback();
                    return;
                }
            };
        @end @*/

        if (document.addEventListener) {
            document.addEventListener('DOMContentLoaded', callback, false);
            return;
        }

        if (/KHTML|WebKit|iCab/i.test(navigator.userAgent)) {
            var DOMLoadTimer = setInterval(function () {
                if (/loaded|complete/i.test(document.readyState)) {
                    callback();
                    clearInterval(DOMLoadTimer);
                    return;
                }
            }, 10);
        }

        window.onload = callback;

    }

    /*==========================================*/
    /* Timers and Intervals */
    /*==========================================*/

    exports.delay = function(callback, time){
        setTimeout(callback, time);
    }

    /*==========================================*/
    /* Date */
    /*==========================================*/

    exports.UNIXTimestamp = function(){
        return Math.round(Date.now() / 1000);
    }

    /*==========================================*/
    /* AJAX Module */
    /*==========================================*/

    var ajax = (function(){

        var xhr,
        data,
        response;

        var _initXHR = function(){
            var xmlhttp;
            try {
                xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                try {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (E) {
                    xmlhttp = false;
                }
            }
            if (!xmlhttp && typeof XMLHttpRequest !== 'undefined') {
                xmlhttp = new XMLHttpRequest();
            }
            return xmlhttp;
        }

        var _checkOptions = function(options){
            var successOnly = false,
            successCallback;

            if(typeof options !== 'object'){
                successOnly = true;
                successCallback = options;
            }

            return {
                singleCallback: successOnly,
                successCallback: successCallback
            }
        }

        var _encodeComponents = function(data){

            if(typeof data !== 'object'){
                new TypeError('blah blah');
            }

            var i = 0, query = '';

            var parameters = Object.keys(data);

            for(; i < parameters.length; i++){
                query += parameters[i] + '=' + encodeURIComponent(data[parameters[i]]);
                if(i !== parameters.length - 1){
                    query += '&';
                }
            }

            return query;
        }

        var get = function (url, options) {

            var checkOptions = _checkOptions(options);

            xhr = _initXHR();

            xhr.open("GET", url, true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if ((xhr.status >= 200 && xhr.status < 300) || xhr.status === 304) {
                        data = xhr.responseText;
                        response = xhr;

                        if(options.json && xhr.getResponseHeader("content-type").indexOf('json') > -1){
                            response.isJSON = true;
                        }

                        checkOptions.singleCallback === false ? options.success(data, response) : checkOptions.successCallback(data, response);
                    }
                    else if(checkOptions.singleCallback === false) {
                        options.error(xhr.status, response);
                    }
                }
            }

            xhr.send();

        }

        var post = function(url, options){

            var encodedData = _encodeComponents(options.data);

            xhr = _initXHR();

            xhr.open("POST", url, true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if ((xhr.status >= 200 && xhr.status < 300) || xhr.status === 304) {
                        data = xhr.responseText;
                        response = xhr;

                        options.success(data, response);
                    } else {
                        options.error(xhr.status, response);
                    }
                }
            }

            xhr.send(encodedData);

        }

        var json = function(url, callback){

            get(url, {
                json: true,
                success: function(data, response){
                    if(response.isJSON){
                        callback(data, response);
                    } else {
                        return false;
                    }
                },
                error: function(data, response){
                    callback(data, response);
                }
            });

        }

        var ajax = function(options){

            options = options || {};

            var type    = options.type,
                url     = options.url,
                data    = options.data;
                success = options.success,
                error   = options.error || function(){};

            var query = _encodeComponents(data);

            if(type === 'GET'){

                get(url + '?' + query, {
                    success: success,
                    error: error
                });
            }
        }

        return {
            get: get,
            post: post,
            json: json,
            ajax: ajax
        }

    })();

    exports.get = ajax.get;
    exports.post = ajax.post;
    exports.json = ajax.json;
    exports.ajax = ajax.ajax;

    /*==========================================*/
    /* Storage Module */
    /*==========================================*/

    var Storage = (function(){

        var is_supported = function(){
            if(typeof(Storage) !== void(0)){
                return true;
            }
            return false;
        }

        var get = function(item){
            if(is_supported()){
                return localStorage.getItem(item);
            }
        }

        var set = function(item, value){
            if(is_supported()){
                localStorage.setItem(item, value);
            }
        }

        var remove = function(item){
            if(is_supported()){
                localStorage.removeItem(item);
            }
        }

        return {
            get    : get,
            set    : set,
            remove : remove
        }

    })();

    exports.storage = Storage;


    //======================
    // Browser Detection
    //======================

    navigator.sayswho=(function(){
      var ua= navigator.userAgent, tem,
      M= ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
      if(/trident/i.test(M[1])){
          tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
          return 'IE '+(tem[1] || '');
      }
      if(M[1]=== 'Chrome'){
          tem= ua.match(/\b(OPR|Edge)\/(\d+)/);
          if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
      }
      M= M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
      if((tem= ua.match(/version\/(\d+)/i))!= null) M.splice(1, 1, tem[1]);
      return M.join(' ');
    })();

    /**
     * getBrowser returns browser name and browser version
     * @return object {name: browser_name, version: browser_version}
     */
    exports.getBrowser = function(){
      var info = {};
      info.name = ((navigator.sayswho).split(" ")[0]).toLowerCase();
      info.version = (navigator.sayswho).split(" ")[1];
      return info;
    }

    exports.replaceChild = function(from, to){
      from.parentNode.replaceChild(to, from);
    }

})(this.$ = {});
