auth = module.exports = 
  get:
    login: (req, res) ->
      res.render 'pages/login',
        user: req.user
        nav: req.Navigation
        title: "Login Page"
        embed: req.Embed
        flash: req.flash "info"
    logout: (req, res) ->
      req.logout()
      delete req.user
      res.redirect "/login"
