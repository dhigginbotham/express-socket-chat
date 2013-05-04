var priv = io.connect('/priv');

priv.on('connected_users', function(data) {
  console.log(data);
});

// on connection to server, ask for user's name with an anonymous callback
priv.on('connect', function(){
  // call the server-side function 'adduser' and send one parameter (value of prompt)
  priv.emit('adduser', getUser());
});

// listener, whenever the server emits 'updatechat', this updates the chat body
priv.on('updatechat', function (username, data) {
  var date = new Date();
  var body = ScriptsClass.replaceURLWithHTMLLinks(data);
  $('#conversation').append(ScriptsClass.formatAMPM(date) + ' - <b style="color: #0044cc;">' + username + ':</b> ' + body + '<br>\r\n');
  emojify.run();
  HandleScrollBar.scrollToBottom();
});

// listener, whenever the server emits 'updateusers', this updates the username list
priv.on('updateusers', function(data) {
  $('#users').empty();
  $.each(data, function(key, value) {
    if (key == 'admin') {
      $('#users').append('<span class="badge badge-important">' + key + '</span>&nbsp;');
    } else {
      $('#users').append('<span class="badge">' + key + '</span>&nbsp;');
    }
  });
});

// on load of page
$(function(){
  // when the client clicks SEND
  $('#datasend').click( function() {
    var message = $('#data').val();
    $('#data').val('');
    $('#data').select();
    // tell server to execute 'sendchat' and send along one parameter
    priv.emit('sendchat', message);
  });

  // when the client hits ENTER on their keyboard
  $('#data').keypress(function(e) {
    if(e.which == 13) {
      $(this).blur();
      $('#datasend').focus().click();
    }
  });
});