//scripts.client.js
var ScriptsClass = (function() {
  var s;

  return {
    settings: {

    },
    init: function() {
      s = this.settings;
    },
    formatAMPM: function (date) {
  
      var hours = date.getHours();
      var minutes = date.getMinutes();
      var ampm = hours >= 12 ? 'PM' : 'AM';
  
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0'+minutes : minutes;
        var strTime = hours + ':' + minutes + ' ' + ampm;
        
          return strTime;
    },
    replaceURLWithHTMLLinks: function (text) {
  
      var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
      
        return text.replace(exp,"<a href='$1' target='_blank'>$1</a>"); 
    }
  };
})();