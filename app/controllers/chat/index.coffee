Chat = require "../../models/chat"
moment = require "moment"

chat = module.exports =
  get:
    public: (req, res) ->

      res.render 'pages/chat',
        user: req.user
        nav: req.Navigation
        title: "Chat Page"
        embed: req.Embed
        flash: req.flash "info"

    private: (req, res) ->

      res.render 'pages/chat',
        user: req.user
        nav: req.Navigation
        title: "Admin Chat Page"
        embed: req.Embed
        flash: req.flash "info"

    history: (req, res) ->
      history = req.pubChatHistory
      # prettyTime = moment new Date(req.pubChatHistory.date), "h:m:A"

      res.render 'pages/history',
        user: req.user
        nav: req.Navigation
        title: "Public Chat History"
        roomtitle: "Public Chat"
        embed: req.Embed
        flash: req.flash "info"
        chats: history
        # time: prettyTime

    PrivateHistory: (req, res) ->
      history = req.privChatHistory

      res.render 'pages/history',
        user: req.user
        nav: req.Navigation
        title: "Public Chat History"
        roomtitle: "Public Chat"
        embed: req.Embed
        flash: req.flash "info"
        chats: history
