main = module.exports =
  get:
    home: (req, res, next) ->
      res.render 'pages/home',
        app: req.Config
        nav: req.Navigation
        title: "Login Page"
        embed: req.Embed