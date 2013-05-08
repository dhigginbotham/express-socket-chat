var HandleScrollBar = (function() {
  var s;
  return {
    settings: {
      chat: $('#conversation'),
      btn: $('#datasend'),
    },
    init: function () {
      s = this.settings;
    },
    scrollToBottom: function () {
      s.chatHeight = s.chat[0].scrollHeight - s.chat.height();
      s.currentScroll = s.chat[0].scrollTop;
      if (s.currentScroll < s.chatHeight - 120) {
        console.log(s.chatHeight);
        console.log(s.currentScroll);
        s.chat[0].scrollTop = s.currentScroll;
      } else {
        s.chat.scrollTop(s.chat[0].scrollHeight);
        // s.chat.animate({ scrollTop: s.chat[0].scrollHeight }, 800);
      }
    }
  }
})();

var ChatButtons = (function () {
  var s;
  return {
    settings: {
      clearChatBtn: $('#clearChat'),
      btn: $('#datasend'),
      chatContainer: $('#conversation')
    },
    init: function () {
      s = this.settings;
      ChatButtons.clearChat();
      ChatButtons.limitChatLength();
    },
    clearChat: function () {
      s.clearChatBtn.on('click', function () {
        s.chatContainer.children().remove();
      });
    },
    limitChatLength: function () {
      s.btn.on('click', function() {
        if (s.chatContainer.children().length > 100) {
          return s.chatContainer.children()[0].remove();
        }
      });
    },
  }
})();
ChatButtons.init();
HandleScrollBar.init();
HelperClass.LoadEmoji();
