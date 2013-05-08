User = require "../../models/users"
users = module.exports =
  get:
    register: (req, res) ->
      res.render 'pages/register',
        user: req.user
        title: "Register Page"
        nav: req.Navigation
        embed: req.Embed
        flash: req.flash "info"
        submit: "Register"

    make: (req, res) ->
      res.render "pages/register",
        title: "Make an account"
        flash: req.flash "info"
        user: req.user
        submit: "Create User"
        nav: req.Navigation
        embed: req.Embed

    uplift: (req, res) ->
      User.update username: req.params.user, admin: true, (err) ->
        if !err
          req.flash "info", type: "error", title: "Oh Snap!", msg: "Welcome, admin"
          res.redirect "back"
        else
          req.flash "info", type: "error", title: "Oh Snap!", msg: "Oh, sorry no admin for you apparently :("
          res.redirect "back"

    remove: (req, res) ->
      User.remove
        username: req.params.user, (err) ->
          return err if err
          res.redirect "back"

    edit: (req, res) ->
      res.render "pages/edit",
        title: "Edit account"
        flash: req.flash "info"
        user: req.user
        submit: "Save Changes"
        nav: req.Navigation
        embed: req.Embed
        edit: req.FindByParam

    userEdit: (req, res) ->
      res.render "pages/edit",
        title: "Manage your account"
        flash: req.flash "info"
        user: req.user
        submit: "Update Account"
        nav: req.Navigation
        embed: req.Embed
        edit: req.FindSelf

    json: (req, res) ->
      res.json(req.findAll)

    view: (req, res) ->
      res.render "pages/view",
        user: req.user
        title: "View Users"
        users: req.findAll
        flash: req.flash "info"
        nav: req.Navigation
        embed: req.Embed
  post:
    register: (req, res) ->
      if !req.form.isValid
        req.flash "info", type: "error", title: "Oh Snap!", msg: req.form.errors
        res.redirect "back"
      res.redirect "/"

    edit: (req, res) ->
      res.redirect "back"

    userEdit: (req, res) ->
      res.redirect "back"

    make: (req, res) ->
      res.redirect "back"