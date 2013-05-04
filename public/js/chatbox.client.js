var HandleScrollBar = (function() {
  var s;
  return {
    settings: {
      chat: $('#conversation'),
      btn: $('#datasend'),
    },
    init: function () {
      s = this.settings;
      HandleScrollBar.scrollToBottom();
    },
    scrollToBottom: function () {
      s.btn.on('click', function() {
        s.chatHeight = s.chat[0].scrollHeight - s.chat.height();
        s.currentScroll = s.chat[0].scrollTop;
        if (s.currentScroll < s.chatHeight) {
          s.chat[0].scrollTop = s.currentScroll;
        } else {
          s.chat.stop().animate({ scrollTop: s.chat[0].scrollHeight }, 800);
        }
      });
    }
  }
})();

HandleScrollBar.init();