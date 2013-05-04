main = module.exports =
  get:
    home: (req, res, next) ->
      res.render 'pages/home',
        user: req.user
        nav: req.Navigation
        title: "Login Page"
        embed: req.Embed