//helpers.client.js
var HelperClass = (function() {
  var s;

  return {
    init: function() {

      s = this.settings;
    },
    settings: {
      //put some defaults here
    },
    DisableForm: function(selector) { 
      /*
      This will disable any form, bind to form id 
      //usage:
        
        HelperClass.DisableForm('#selector');
        you have to put in the id or class value, it's not
        that smart

      */
      var selector = $(selector);

      if (selector) {

        selector.submit(function(e){

          selector.children('input[type=submit], input[type=button]').attr('disabled', 'disabled');
          e.preventDefault(); 

          return false;
        });
      } else {

        return false;
      }
    },
    ClickForwarder: function(selector, destination) {
      /*
      This will forward you to any destination
      //usage:
        
        HelperClass.ClickForwarder('#selector', '/slug');

      */      
      $(selector).bind('click', function() {

        self.location.href=destination;
      });
    },
    BindSocketIO: function(selector, event, data) {
      /*
      This quickly binds Socket.io
      //usage:

        HelperClass.BindSocketIO('#selector', 'event_title', object);

      */
      $(selector).bind('click', function() {

        socket.emit(event, data);
      });
    },
    LoadEmoji: function () {
      emojify.setConfig({
          // emojify_tag_type: 'img',
          emoticons_enabled: true,
          people_enabled: true,
          nature_enabled: true,
          objects_enabled: true,
          places_enabled: true,
          symbols_enabled: true,
          only_crawl_id: 'conversation'  //only do this when you want to restrict where emojify looks.
      });

      emojify.run();
    }
  }
})();