chat = module.exports =
  get:
    public: (req, res) ->
      res.render 'pages/chat',
        nav: req.Navigation
        title: "Chat Page"
        embed: req.Embed
        flash: req.flash "info"
    private: (req, res) ->
      res.render 'pages/chat',
        nav: req.Navigation
        title: "Admin Chat Page"
        embed: req.Embed
        flash: req.flash "info"      