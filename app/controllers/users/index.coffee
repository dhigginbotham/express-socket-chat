users = module.exports =
  get:
    register: (req, res) ->
      res.render 'pages/register',
        app: req.Config
        nav: req.Navigation
        title: "Register Page"
        embed: req.Embed
        flash: req.flash "info"
  post:
    register: (req, res) ->
      res.redirect "/"