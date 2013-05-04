main = module.exports =
  get:
    home: (req, res, next) ->
      res.render 'pages/home',
        nav: req.Navigation
        title: "Login Page"
        embed: req.Embed